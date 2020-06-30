Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB95A20FC2D
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Jun 2020 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgF3SuE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Jun 2020 14:50:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25770 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbgF3SuD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 30 Jun 2020 14:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593543001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ILNVKniPuWCOaWJSWnYpx92u7nfQ4dnGhDKgu/Th5Fo=;
        b=DkOSO0+zdLoaIzqnP35bIgprRZ0Cbv7T5ACVP3rcmZnL0BEHuLyKLedIXaqM7WkFJ+Pcix
        gLmAqXJ1xZQ0tXJhHwUUt2yKAEMOitdoXwMYNDmcu+2Dx5bkvzBHC0yOAfvI9wlfaQ/hDL
        ojsjbGTXL0zLWuyo3y1RpzQVS248wbk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-_FhOcECqPiOdi18y6KDsrg-1; Tue, 30 Jun 2020 14:50:00 -0400
X-MC-Unique: _FhOcECqPiOdi18y6KDsrg-1
Received: by mail-qv1-f69.google.com with SMTP id em19so8731157qvb.14
        for <linux-fpga@vger.kernel.org>; Tue, 30 Jun 2020 11:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ILNVKniPuWCOaWJSWnYpx92u7nfQ4dnGhDKgu/Th5Fo=;
        b=gzkzrjPbyzdoPwJWrMVxO+cMp8yJus/Pcxsvsh4h9axGWNtEzPUH7N2Jo42LBYssmB
         sIyM1nF1D/GMlH6qfT8jhic0JwUZmjRwdEMAbTB6Mg5CfU+0y56CJv+smE690BD2daFV
         m2a17r/0eULqV4K/3Wtgy5CCfC0wN2hwXtxfSApp9PUxRA+L7psF5kQAQfQYdjrlUYIn
         kx2X4GTNC2PFABAMnh1I5dMENhXGGa9j3kHm6VKBbOfcyoTzhWpVpHXrB0+4/XSIghnb
         UhmXwJB4tWO7QrNn/PpQJSN6bX4woM+oeQwFx0L1cBCYPUyqhIxcXQpsgEUSCGeJiQ3i
         knlw==
X-Gm-Message-State: AOAM5308ZyVgWk+Mz5Otu63PD4qqE3FbxtXMEpfKeM/xZTl8qTmovqzi
        4csKjdiDatW0zL2TVUVRA1/XCMtPW5OBPuiXiL5P5PxPBwOuGhi81oITwFJHnQ6xCCAgeXadxxw
        PRdcjzaBDCMnsywdJbdGPTw==
X-Received: by 2002:ac8:774d:: with SMTP id g13mr21842273qtu.317.1593542999898;
        Tue, 30 Jun 2020 11:49:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOfMipnw5vbBXdCY5Q+BjXTkajzbWmU1TAYr4mNpQfWkuqZDJBk6gfVOWRsXKjiG1BhXvUJQ==
X-Received: by 2002:ac8:774d:: with SMTP id g13mr21842251qtu.317.1593542999620;
        Tue, 30 Jun 2020 11:49:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b10sm3410280qkh.124.2020.06.30.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:49:59 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [RFC v2] fpga: dfl: RFC PCI config
Date:   Tue, 30 Jun 2020 11:49:50 -0700
Message-Id: <20200630184950.950-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Create some top level configs the map to dfl pci cards.

Autoselect the parts of fpga that are needed to run these cards
as well as the defining the other subsystem dependencies.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 v1 change subsystem selects to depends

 Documentation/fpga/dfl.rst | 30 ++++++++++++++++++++++++++++++
 drivers/fpga/Kconfig       | 27 +++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index d7648d7c7eee..c1ae6b539f08 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -500,6 +500,36 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
+Kernel configuration
+====================
+
+While it is possible to manually setup a configuration to match your device,
+there are some top level configurations that collect configurations for
+some reference PCI cards.  Below describes these configuration as well as
+what other kernel configs are needed for proper configuration.
+
+FPGA_DFL_PAC10
+Intel Arria 10 GX PCI card, PCI id 0X09C4
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  SENSORS_INTEL_M10_BMC_HWMON
+
+FPGA_DFL_D5005
+Intel Stratix 10, D5005 PCI card, PCI id 0X0B2B
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  SENSORS_INTEL_M10_BMC_HWMON
+  INTEL_S10_PHY
+
+FPGA_DFL_N3000
+Intel Network Accelerator, N3000 PCI card, PCI id 0X0B30
+Depends on
+  SPI_ALTERA
+  MFD_INTEL_M10_BMC
+  SENSORS_INTEL_M10_BMC_HWMON
+  INTEL_LL_10G_MAC
 
 Open discussion
 ===============
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 9d53bd9094e2..96603b1f6ff5 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -138,6 +138,33 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
+config FPGA_DFL_PAC10
+	tristate "Intel Arria 10 GX PCI card"
+	depends on SPI_ALTERA
+	depends on SENSORS_INTEL_M10_BMC_HWMON
+	depends on MFD_INTEL_M10_BMC
+	select FPGA_DFL
+	select FPGA_DFL_FME
+	select FPGA_DFL_FME_MGR
+	select FPGA_DFL_FME_BRIDGE
+	select FPGA_DFL_FME_REGION
+	select FPGA_DFL_AFU
+	select FPGA_DFL_SPI_ALTERA
+	select FPGA_DFL_PCI
+	select IFPGA_SEC_MGR
+
+config FPGA_DFL_D5005
+	tristate "Intel Stratix 10, D5005 PCI card"
+	depends on INTEL_S10_PHY
+	select FPGA_DFL_PAC10
+	select FPGA_DFl_HSSI
+
+config FPGA_DFL_N3000
+	tristate "Intel Network Accelerator, N3000 PCI card"
+	depends on INTEL_LL_10G_MAC
+	select FPGA_DFL_PAC10
+	select FPGA_DFL_N3000_NIOS
+
 config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
-- 
2.18.1

