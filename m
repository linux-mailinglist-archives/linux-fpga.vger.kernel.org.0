Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0789280A7C
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Aug 2019 12:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfHDKhv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Aug 2019 06:37:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:31912 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfHDKhu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 4 Aug 2019 06:37:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2019 03:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,345,1559545200"; 
   d="scan'208";a="167678922"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2019 03:37:48 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>, Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v4 02/12] fpga: dfl: pci: enable SRIOV support.
Date:   Sun,  4 Aug 2019 18:20:12 +0800
Message-Id: <1564914022-3710-3-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch enables the standard sriov support. It allows user to
enable SRIOV (and VFs), then user could pass through accelerators
(VFs) into virtual machine or use VFs directly in host.

Signed-off-by: Zhang Yi Z <yi.z.zhang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: remove DRV/MODULE_VERSION modifications.
v4: split __dfl_fpga_cdev_config_port_vf into 2 functions with
    locking added.
---
 drivers/fpga/dfl-pci.c | 36 ++++++++++++++++++++++
 drivers/fpga/dfl.c     | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h     |  3 +-
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 66b5720..89ca292 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -223,8 +223,43 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 	return ret;
 }
 
+static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct dfl_fpga_cdev *cdev = drvdata->cdev;
+	int ret = 0;
+
+	if (!num_vfs) {
+		/*
+		 * disable SRIOV and then put released ports back to default
+		 * PF access mode.
+		 */
+		pci_disable_sriov(pcidev);
+
+		dfl_fpga_cdev_config_ports_pf(cdev);
+
+	} else {
+		/*
+		 * before enable SRIOV, put released ports into VF access mode
+		 * first of all.
+		 */
+		ret = dfl_fpga_cdev_config_ports_vf(cdev, num_vfs);
+		if (ret)
+			return ret;
+
+		ret = pci_enable_sriov(pcidev, num_vfs);
+		if (ret)
+			dfl_fpga_cdev_config_ports_pf(cdev);
+	}
+
+	return ret;
+}
+
 static void cci_pci_remove(struct pci_dev *pcidev)
 {
+	if (dev_is_pf(&pcidev->dev))
+		cci_pci_sriov_configure(pcidev, 0);
+
 	cci_remove_feature_devs(pcidev);
 	pci_disable_pcie_error_reporting(pcidev);
 }
@@ -234,6 +269,7 @@ static void cci_pci_remove(struct pci_dev *pcidev)
 	.id_table = cci_pcie_id_tbl,
 	.probe = cci_pci_probe,
 	.remove = cci_pci_remove,
+	.sriov_configure = cci_pci_sriov_configure,
 };
 
 module_pci_driver(cci_pci_driver);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 70ffe8b..b913704 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1131,6 +1131,88 @@ int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_cdev_assign_port);
 
+static void config_port_access_mode(struct device *fme_dev, int port_id,
+				    bool is_vf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(fme_dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_PORT_OFST(port_id));
+
+	v &= ~FME_PORT_OFST_ACC_CTRL;
+	v |= FIELD_PREP(FME_PORT_OFST_ACC_CTRL,
+			is_vf ? FME_PORT_OFST_ACC_VF : FME_PORT_OFST_ACC_PF);
+
+	writeq(v, base + FME_HDR_PORT_OFST(port_id));
+}
+
+#define config_port_vf_mode(dev, id) config_port_access_mode(dev, id, true)
+#define config_port_pf_mode(dev, id) config_port_access_mode(dev, id, false)
+
+/**
+ * dfl_fpga_cdev_config_ports_pf - configure ports to PF access mode
+ *
+ * @cdev: parent container device.
+ *
+ * This function is needed in sriov configuration routine. It could be used to
+ * configure the all released ports from VF access mode to PF.
+ */
+void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev)
+{
+	struct dfl_feature_platform_data *pdata;
+
+	mutex_lock(&cdev->lock);
+	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
+		if (device_is_registered(&pdata->dev->dev))
+			continue;
+
+		config_port_pf_mode(cdev->fme_dev, pdata->id);
+	}
+	mutex_unlock(&cdev->lock);
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_pf);
+
+/**
+ * dfl_fpga_cdev_config_ports_vf - configure ports to VF access mode
+ *
+ * @cdev: parent container device.
+ * @num_vfs: VF device number.
+ *
+ * This function is needed in sriov configuration routine. It could be used to
+ * configure the released ports from PF access mode to VF.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
+{
+	struct dfl_feature_platform_data *pdata;
+	int ret = 0;
+
+	mutex_lock(&cdev->lock);
+	/*
+	 * can't turn multiple ports into 1 VF device, only 1 port for 1 VF
+	 * device, so if released port number doesn't match VF device number,
+	 * then reject the request with -EINVAL error code.
+	 */
+	if (cdev->released_port_num != num_vfs) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
+		if (device_is_registered(&pdata->dev->dev))
+			continue;
+
+		config_port_vf_mode(cdev->fme_dev, pdata->id);
+	}
+done:
+	mutex_unlock(&cdev->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_vf);
+
 static void __exit dfl_fpga_exit(void)
 {
 	dfl_chardev_uinit();
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 6f7855e..b3f2f53 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -416,5 +416,6 @@ struct platform_device *
 
 int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id);
 int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id);
-
+void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev);
+int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vf);
 #endif /* __FPGA_DFL_H */
-- 
1.8.3.1

