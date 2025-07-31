def main():
    """Custom autotiling behavior"""
    # You can add custom rules here
    # For example, exclude certain applications from autotiling
    excluded_apps = ['Steam', 'spotify', 'pavucontrol']

    # Default autotiling behavior works great for most cases
    subprocess.run(['autotiling'])

if __name__ == "__main__":
    main()
