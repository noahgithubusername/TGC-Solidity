import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

// Asset class to store asset information
class Asset {
    private int id;
    private String name;
    private double value;

    public Asset(int id, String name, double value) {
        this.id = id;
        this.name = name;
        this.value = value;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getValue() {
        return value;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setValue(double value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "Asset{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", value=" + value +
                '}';
    }
}

// AssetManager class to manage assets
class AssetManager {
    private List<Asset> assets;

    public AssetManager() {
        assets = new ArrayList<>();
    }

    public void addAsset(Asset asset) {
        assets.add(asset);
    }

    public List<Asset> getAllAssets() {
        return assets;
    }

    public Asset getAssetById(int id) {
        for (Asset asset : assets) {
            if (asset.getId() == id) {
                return asset;
            }
        }
        return null;
    }

    public void editAsset(int id, String newName, double newValue) {
        Asset asset = getAssetById(id);
        if (asset != null) {
            asset.setName(newName);
            asset.setValue(newValue);
            System.out.println("Asset updated successfully!");
        } else {
            System.out.println("Asset not found.");
        }
    }

    public void deleteAsset(int id) {
        Asset asset = getAssetById(id);
        if (asset != null) {
            assets.remove(asset);
            System.out.println("Asset deleted successfully!");
        } else {
            System.out.println("Asset not found.");
        }
    }
}

public class AssetManagementApp {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        AssetManager assetManager = new AssetManager();

        while (true) {
            System.out.println("Asset Management System");
            System.out.println("1. Add Asset");
            System.out.println("2. View Assets");
            System.out.println("3. Edit Asset");
            System.out.println("4. Delete Asset");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.print("Enter asset name: ");
                    String name = scanner.next();
                    System.out.print("Enter asset value: ");
                    double value = scanner.nextDouble();
                    Asset newAsset = new Asset(assetManager.getAllAssets().size() + 1, name, value);
                    assetManager.addAsset(newAsset);
                    System.out.println("Asset added successfully!");
                    break;
                case 2:
                    System.out.println("All Assets:");
                    for (Asset asset : assetManager.getAllAssets()) {
                        System.out.println(asset);
                    }
                    break;
                case 3:
                System.out.print("Enter asset ID to edit: ");
                int editId = scanner.nextInt();
                Asset editAsset = assetManager.getAssetById(editId);
                if (editAsset != null) {
                    System.out.print("Enter new asset name: ");
                    String newName = scanner.next();
                    System.out.print("Enter new asset value: ");
                    double newValue = scanner.nextDouble();
                    assetManager.editAsset(editId, newName, newValue);
                } else {
                    System.out.println("Asset not found.");
                }
                break;
                case 4:
                    System.out.print("Enter asset ID to delete: ");
                    int deleteId = scanner.nextInt();
                    assetManager.deleteAsset(deleteId);
                    break;
                case 5:
                    System.out.println("Exiting the application. Goodbye!");
                    System.exit(0);
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }
}
