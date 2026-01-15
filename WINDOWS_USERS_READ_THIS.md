# Windows Users - Quick Start

## ✅ Use These Commands

### Deploy the Lab
```cmd
deploy.bat
```

### Clean Up
```cmd
cleanup.bat
```

## Why Not .ps1 Files?

If you tried running `deploy.ps1` and got an error about "execution policies", that's normal Windows security. 

**Solution:** Use the `.bat` files instead - they work without any configuration!

## What If I Want to Use PowerShell?

See `POWERSHELL_FIX.md` for detailed instructions, or use this quick bypass:

```powershell
PowerShell -ExecutionPolicy Bypass -File .\deploy.ps1
```

## Need Help?

1. Make sure Minikube is running: `minikube start`
2. Use the `.bat` files (easiest option)
3. Check `POWERSHELL_FIX.md` for more options

---

**Ready to start? Just run:**
```cmd
deploy.bat
```

🎉 That's it!
