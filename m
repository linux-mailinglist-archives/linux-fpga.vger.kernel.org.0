Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74471552C
	for <lists+linux-fpga@lfdr.de>; Tue, 30 May 2023 07:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjE3FuI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 May 2023 01:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjE3FuG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 May 2023 01:50:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB50E5
        for <linux-fpga@vger.kernel.org>; Mon, 29 May 2023 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685425804; x=1716961804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cJaUbBJqIwgBcTiOFuCJmKjYigELpgOVcO8+uSBdYKs=;
  b=IeCuToHtu5gBNH2FKWWF4q8L+Sm3qW6/JKd3Kcpvu5CvJEStnfj37Wqn
   w/FNxoWYVe/nNFxRyXv9O6sUNvRNfgrWRJgkK0Zn75usBJE10FO2xP87m
   4U4aH7l6fcV6dzIm5+IRecxlzUO3ouCdHVD2DaJlff7I+HXC/Xxwl1CCe
   rfFXnYNTMblp+LTt3mxrg/sFoxGglifDImMUWG9Qvxbd/bmHIwQvVf2rg
   OEZ+a9mnRmjp2L5QSP+tttaBAIigguCuyGAaZ/kOKiCOJ6mJC61QLNutL
   Xk5zUqxOBUm9hqkmNZ3PKoV8xmdgP3c73VxgX5gz6CQ+PVjD53BmkXfZP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="420581544"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="420581544"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 22:50:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="952982496"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="952982496"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 29 May 2023 22:50:03 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [PATCH 2/2] dt-bindings: fpga: replace Ivan Bornyakov maintainership
Date:   Tue, 30 May 2023 21:49:36 +0800
Message-Id: <20230530134936.634370-3-yilun.xu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530134936.634370-1-yilun.xu@intel.com>
References: <20230530134936.634370-1-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Ivan Bornyakov <i.bornyakov@metrotek.ru>

As I'm leaving Metrotek, hand over Lattice Slave SPI sysCONFIG FPGA
manager and Microchip Polarfire FPGA manager maintainership duties to
Vladimir.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230429104838.5064-3-i.bornyakov@metrotek.ru
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
 .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
index 4fb05eb84e2a..164331eb6275 100644
--- a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
+++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Lattice Slave SPI sysCONFIG FPGA manager
 
 maintainers:
-  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+  - Vladimir Georgiev <v.georgiev@metrotek.ru>
 
 description: |
   Lattice sysCONFIG port, which is used for FPGA configuration, among others,
diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
index 527532f039ce..a157eecfb5fc 100644
--- a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Microchip Polarfire FPGA manager.
 
 maintainers:
-  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+  - Vladimir Georgiev <v.georgiev@metrotek.ru>
 
 description:
   Device Tree Bindings for Microchip Polarfire FPGA Manager using slave SPI to
-- 
2.25.1

