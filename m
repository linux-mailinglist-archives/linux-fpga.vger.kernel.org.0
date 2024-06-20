Return-Path: <linux-fpga+bounces-550-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD84E9108AA
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 16:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738B72848D6
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE0A1AE086;
	Thu, 20 Jun 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdN3+4+r"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3719B3E1;
	Thu, 20 Jun 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894556; cv=none; b=H/soIJ0o8l/9oOzAzswFIMkynwVYJIE59wODKTCnB9XIGKT3VZulGZ7i9ZO8vMNcxcAVq9m2MlI3oKhLBIS1uZEqs0qQc0NvYjICcKE1Lnpzx3v6Flc6NyzFz37fg+tzPmG0EPWRd98NynVS+6JO3XEQ9SPgga470a3+D5SVQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894556; c=relaxed/simple;
	bh=0du4LzyRFU3lvqnsKowKPxc+hqF+QIx3vlZa8Q6mLxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yf1oFHJlpFbuQTszdxTzLtYw5OOwaUnBO8DYB94y9U7lxUhAknqUfnDg9/9Tb8EWFiuu0LpYvHZ6melJR60Htj4oQI2K7TcLyzdS3U/s11sN4otlTr4836/CJuOOvlcxnxJV/GTEH7BdC1/435l1qkyUfECS50Lpt67nLBywVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdN3+4+r; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so975163a12.2;
        Thu, 20 Jun 2024 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718894553; x=1719499353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9yYi2tnd7ItitxdYCCfVPYDVT9N1o3R38RONDqLcVo=;
        b=NdN3+4+rx0/oNQ4k4Gz69LIO6EGJFX/84M59Ph9DWbfwVikjZClPwKdb3SuCZv0VCZ
         oNzbHfwnBisA7JsWiK302tYkuc+d0TpT5CAtcpgdWJwWwtbXi2E0rbMXxxdCa1Ki8VOE
         W3TQY2TPmOvKL6/k4Kp4ypJ+xNNMGVmhde2SPkIqCmNn3JcsJoVwk4SdqswCutBbVd84
         MI16WOjOL7+UOomQ0BVIU6yd7TWxmnbAvVzv3G7Q8eUCus2aCOtFZhtZRWFI2PY1flVR
         TFphstuaXte4tdxbLBmp9ThvQlHhHGR4gvl7H/w0e34z3Y6G55pWuRInK3+27X7ReNw5
         /d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894553; x=1719499353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9yYi2tnd7ItitxdYCCfVPYDVT9N1o3R38RONDqLcVo=;
        b=HuIr+WtSo27SIdrdWT6Jzxa4qi7149yKrQezeZ/LmSBh2wIjqkVUmcK4PB+0JGbnRs
         v+RNpAHeFWWCr7ADAzf6l2Fh92X2u110gYcE8xHOQXm3HFO2LrjLVWQT47rOo/WE0QIz
         J91E8p1ySGBup24xV+6Ap7ZjpdoHiTxazbtkVTK0pe81j0mHHXXcoQ57fXua6T8S7ciR
         TxQcZBOSi1Z3hHPhnV5rvfG9HCBE1igi52OyjFR+kz9Dm++/oY30+2E7yLHs8IQaeCXS
         w2PRy7B6HzTo3n2SeuobWxMlQ+1VqZ31aK2q8UQympg44dTt/MJDewGggv+16hB0ozab
         CkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH2aMGVSgUP+3fwEhuPLvP/ueLj/YCR3po7UQ4BS9vT/UDClNHPLKjgm9PjoDZ3niKl8elyNJEQjzcFM1Ar2baRNjG/Siqah9EJ7Hs0N6UIIPCTj3fErm8b1Do9kKY6rggw7O/Ckp9Yg==
X-Gm-Message-State: AOJu0YzkDQ/N6o6qBSKMB8ihiCHplu27pGL5fcH/egp+ucrZQHk3+aKp
	DEJ1d7IFrcAeOh0zJPEpqKxx1KjKN4xyI8Pf6rzgrJ40AWDebL73
X-Google-Smtp-Source: AGHT+IEhtjdWD/Kkpv4xVWKQn3NHXWy3Wj3jh8phXZPzJkYC3P1Z9SFHDgE4HfBhWEk5EljMYtGRLw==
X-Received: by 2002:a17:906:b890:b0:a66:414c:2abf with SMTP id a640c23a62f3a-a6fab62f46cmr303907166b.26.1718894552211;
        Thu, 20 Jun 2024 07:42:32 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f2e9b00caea2d1d6a49249f.dip0.t-ipconnect.de. [2003:eb:5f2e:9b00:caea:2d1d:6a49:249f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa415dsm780915466b.220.2024.06.20.07.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:42:31 -0700 (PDT)
From: iansdannapel@gmail.com
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Cc: Ian Dannapel <iansdannapel@gmail.com>
Subject: [PATCH 1/3] fpga: Add Efinix Trion & Titanium serial SPI programming driver
Date: Thu, 20 Jun 2024 16:42:17 +0200
Message-Id: <20240620144217.124733-1-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add a new driver for loading binary firmware using "SPI passive
programming" on Efinix FPGAs.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 drivers/fpga/Kconfig      |   8 ++
 drivers/fpga/Makefile     |   1 +
 drivers/fpga/efinix-spi.c | 219 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 drivers/fpga/efinix-spi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 37b35f58f0df..cb3a6628fa71 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -83,6 +83,14 @@ config FPGA_MGR_XILINX_SPI
 	  FPGA manager driver support for Xilinx FPGA configuration
 	  over slave serial interface.
 
+config FPGA_MGR_EFINIX_SPI
+	tristate "Efinix FPGA configuration over SPI passive"
+	depends on SPI
+	help
+	  This option enables support for the FPGA manager driver to configure
+	  Efinix Trion and Titanium Series FPGAs over SPI using passive serial
+	  mode.
+
 config FPGA_MGR_ICE40_SPI
 	tristate "Lattice iCE40 SPI"
 	depends on OF && SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index aeb89bb13517..adbd51d2cd1e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
+obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
diff --git a/drivers/fpga/efinix-spi.c b/drivers/fpga/efinix-spi.c
new file mode 100644
index 000000000000..7f7d7e6714ae
--- /dev/null
+++ b/drivers/fpga/efinix-spi.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Trion and Titanium Series FPGA SPI Passive Programming Driver
+ *
+ * Copyright (C) 2024 iris-GmbH infrared & intelligent sensors
+ *
+ * Ian Dannapel <iansdannapel@gmail.com>
+ *
+ * Manage Efinix FPGA firmware that is loaded over SPI using
+ * the serial configuration interface.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+#include <linux/sizes.h>
+
+struct efinix_spi_conf {
+	struct spi_device *spi;
+	struct gpio_desc *done;
+	struct gpio_desc *reset;
+	struct gpio_desc *cs;
+	enum fpga_mgr_states state;
+};
+
+static int get_done_gpio(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	int ret = 0;
+
+	if (conf->done) {
+		ret = gpiod_get_value(conf->done);
+		if (ret < 0)
+			dev_err(&mgr->dev, "Error reading DONE (%d)\n", ret);
+	}
+
+	return ret;
+}
+
+static void reset(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	gpiod_set_value(conf->reset, 1);
+	/* wait tCRESET_N */
+	usleep_range(5, 15);
+	gpiod_set_value(conf->reset, 0);
+	conf->state = FPGA_MGR_STATE_RESET;
+}
+
+static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	return conf->state;
+}
+
+static int efinix_spi_apply_clk_cycles(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	char data[13] = {0};
+
+	return spi_write(conf->spi, data, sizeof(data));
+}
+
+static int efinix_spi_write_init(struct fpga_manager *mgr,
+				 struct fpga_image_info *info,
+				 const char *buf, size_t count)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
+		return -EINVAL;
+	}
+
+	/* reset with chip select active */
+	gpiod_set_value(conf->cs, 1);
+	usleep_range(5, 15);
+	reset(mgr);
+
+	/* wait tDMIN */
+	usleep_range(100, 150);
+
+	return 0;
+}
+
+static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
+			    size_t count)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	int ret;
+
+	ret = spi_write(conf->spi, buf, count);
+	if (ret) {
+		dev_err(&mgr->dev, "SPI error in firmware write: %d\n",
+			ret);
+		return ret;
+	}
+
+	/* append at least 100 clock cycles */
+	efinix_spi_apply_clk_cycles(mgr);
+
+	/* release chip select */
+	gpiod_set_value(conf->cs, 0);
+
+	return 0;
+}
+
+static int efinix_spi_write_complete(struct fpga_manager *mgr,
+				     struct fpga_image_info *info)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	unsigned long timeout =
+		jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
+	bool expired = false;
+	int done;
+
+	if (conf->done) {
+		while (!expired) {
+			expired = time_after(jiffies, timeout);
+
+			done = get_done_gpio(mgr);
+			if (done < 0)
+				return done;
+
+			if (done)
+				break;
+		}
+	}
+
+	if (expired)
+		return -ETIMEDOUT;
+
+	/* wait tUSER */
+	usleep_range(75, 125);
+
+	return 0;
+}
+
+static const struct fpga_manager_ops efinix_spi_ops = {
+	.state = efinix_spi_state,
+	.write_init = efinix_spi_write_init,
+	.write = efinix_spi_write,
+	.write_complete = efinix_spi_write_complete,
+};
+
+static int efinix_spi_probe(struct spi_device *spi)
+{
+	struct efinix_spi_conf *conf;
+	struct fpga_manager *mgr;
+
+	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
+	if (!conf)
+		return -ENOMEM;
+
+	conf->spi = spi;
+	conf->state = FPGA_MGR_STATE_UNKNOWN;
+
+	conf->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->reset))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->reset),
+				"Failed to get RESET gpio\n");
+
+	conf->cs = devm_gpiod_get(&spi->dev, "cs", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->cs))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->cs),
+				"Failed to get CHIP_SELECT gpio\n");
+
+	if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->cs),
+				"Unsupported SPI mode, set CPHA and CPOL\n");
+
+	conf->done = devm_gpiod_get_optional(&spi->dev, "done", GPIOD_IN);
+	if (IS_ERR(conf->done))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
+				"Failed to get DONE gpio\n");
+
+	mgr = devm_fpga_mgr_register(&spi->dev,
+				"Efinix SPI Passive Programming FPGA Manager",
+					&efinix_spi_ops, conf);
+
+	return PTR_ERR_OR_ZERO(mgr);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id efnx_spi_of_match[] = {
+	{ .compatible = "efnx,fpga-spi-passive", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, efnx_spi_of_match);
+#endif
+
+static const struct spi_device_id efinix_ids[] = {
+	{ "fpga-spi-passive", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, efinix_ids);
+
+
+static struct spi_driver efinix_spi_passive_driver = {
+	.driver = {
+		.name = "efnx-fpga-spi-passive",
+		.of_match_table = of_match_ptr(efnx_spi_of_match),
+	},
+	.probe = efinix_spi_probe,
+	.id_table = efinix_ids,
+};
+
+module_spi_driver(efinix_spi_passive_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
+MODULE_DESCRIPTION("Load Efinix FPGA firmware over SPI passive");
-- 
2.34.1


