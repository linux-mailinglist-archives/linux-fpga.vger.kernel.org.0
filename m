Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4BF20C8AB
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Jun 2020 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgF1PSY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Jun 2020 11:18:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725965AbgF1PSY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 28 Jun 2020 11:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593357502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=VIiRpg2HMcYH3miez2YP0TJHh+8l2/Xf7TTOHwjLZVc=;
        b=JH5AUrY6YV11wRbz1xBJ1h899Vtc3NdZSkdBLHbIZA9lWFmI/Wwmqe4hueflcvpWE2RlQy
        0Y5M2YhKvAaJL8wcItywwiAVqhODiQk1yP9u8qBzIqbjh2npDtaGhOAcXFcJG3vmKALKDS
        yZVfyg1YRkJrMYj09ky23gH8CusdZ+g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-XQPdDbKvMJmGqHIpQVolyw-1; Sun, 28 Jun 2020 11:18:20 -0400
X-MC-Unique: XQPdDbKvMJmGqHIpQVolyw-1
Received: by mail-qk1-f200.google.com with SMTP id v16so372887qka.18
        for <linux-fpga@vger.kernel.org>; Sun, 28 Jun 2020 08:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VIiRpg2HMcYH3miez2YP0TJHh+8l2/Xf7TTOHwjLZVc=;
        b=iUK21HNmNpUS44hWgUa9MXIuOuqsqKw6zRrGyGHJL6LUWLGk+2rVRgQNkLxeI0XF3D
         Nd3dR3Zl0HBDG5mR6INMUsEyUJK24c3m82WdqMRqkE2K9bvgFe0vTSo8wFH72HglxG2J
         MgQ/Q8n/+oR95RKrQb6EQ8ZPeR0mYFm9YnXcb3a68hAqLz05i6HbSq8ek5/xWQAoHIKG
         hiSFaDdAQGqO+I9EqVUcGd++6wg7SCWBigSxSYctwRmHh79jnER/bx+6y3vlN7CspIhh
         B3NvbLnCcEigfN50dTjLSKIcaC71tU2G6BusbWEcwuYhKh/HovxXFYVYkWE5Q5v3kgqI
         3XuQ==
X-Gm-Message-State: AOAM530KZy5Tm84eB6HMu6QOdEWPlF8KzT3eSXmMWMYbFfKMOu4+5SRC
        3DGyCEZJVstMvrCE8Ek48z5Mf0gSRJK05e1oih5O3brUv7ijQeqhgIuf82sQDxC0JpEDcK7su/y
        KdvE6K5Wo4cVm+DJpj3pvfQ==
X-Received: by 2002:a37:6388:: with SMTP id x130mr1227802qkb.220.1593357500168;
        Sun, 28 Jun 2020 08:18:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYwcyPZwjUj8AFBJ+MhLk2JfZrttXkDX3IvfuM3nkex36XoZj769AGHUhO6+omwCCFp/3c2g==
X-Received: by 2002:a37:6388:: with SMTP id x130mr1227788qkb.220.1593357499916;
        Sun, 28 Jun 2020 08:18:19 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o15sm13755578qko.67.2020.06.28.08.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 08:18:19 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Date:   Sun, 28 Jun 2020 08:18:13 -0700
Message-Id: <20200628151813.7679-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

To use a dfl pci device, several dfl configs need to be selected.
This is tedious and error prone.

So automagically select the needed configs when FPGA_DFL_PCI
is selected.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/Kconfig | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7cd5a29fc437..4b9e05af5426 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -138,6 +138,27 @@ config OF_FPGA_REGION
 	  Support for loading FPGA images by applying a Device Tree
 	  overlay.
 
+config FPGA_DFL_PCI
+	tristate "FPGA DFL PCIe Device Driver"
+	depends on PCI
+	select FPGA_DFL
+	select FPGA_DFL_FME
+	select FPGA_DFL_FME_MGR
+	select FPGA_DFL_FME_BRIDGE
+	select FPGA_DFL_FME_REGION
+	select FPGA_DFL_AFU
+	help
+	  Select this option to enable PCIe driver for PCIe-based
+	  Field-Programmable Gate Array (FPGA) solutions which implement
+	  the Device Feature List (DFL). This driver provides interfaces
+	  for userspace applications to configure, enumerate, open and access
+	  FPGA accelerators on the FPGA DFL devices, enables system level
+	  management functions such as FPGA partial reconfiguration, power
+	  management and virtualization with DFL framework and DFL feature
+	  device drivers.
+
+	  To compile this as a module, choose M here.
+
 config FPGA_DFL
 	tristate "FPGA Device Feature List (DFL) support"
 	select FPGA_BRIDGE
@@ -191,21 +212,6 @@ config FPGA_DFL_AFU
 	  to the FPGA infrastructure via a Port. There may be more than one
 	  Port/AFU per DFL based FPGA device.
 
-config FPGA_DFL_PCI
-	tristate "FPGA DFL PCIe Device Driver"
-	depends on PCI && FPGA_DFL
-	help
-	  Select this option to enable PCIe driver for PCIe-based
-	  Field-Programmable Gate Array (FPGA) solutions which implement
-	  the Device Feature List (DFL). This driver provides interfaces
-	  for userspace applications to configure, enumerate, open and access
-	  FPGA accelerators on the FPGA DFL devices, enables system level
-	  management functions such as FPGA partial reconfiguration, power
-	  management and virtualization with DFL framework and DFL feature
-	  device drivers.
-
-	  To compile this as a module, choose M here.
-
 config FPGA_MGR_ZYNQMP_FPGA
 	tristate "Xilinx ZynqMP FPGA"
 	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
-- 
2.18.1

