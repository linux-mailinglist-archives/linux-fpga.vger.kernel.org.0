Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F5F55366C
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352957AbiFUPkL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 11:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352773AbiFUPkI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 11:40:08 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBBF19286;
        Tue, 21 Jun 2022 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=4Ik1qUdS4+QkCdU36XYMTDimWksi8zUBnoBPB0cv7hU=;
        b=kAtusXuQQ/pkEGEQiteES0intNB9Cv3EPKtJ63NWw4QBgJQBh+feCN6NV1LldygK1erQFCdNlZz1h
         NEJjP4ddQmA57zs7v0EceocrrBKXE4qpwF+wbbqNA9d+x4I3irmZJkDbX9T1qkqfFVIgz4vUktK+YN
         5h4iHUsIUYQSfMFEzFsK0srXYwAQ9DFZAsu86+Z61Jrb2Ij8vb6uJxUC2lVQEJbxp8s6QP2snhCfFU
         r9a//xaYtsxzkTSMDff/ads+gukptBSQ6wav+f9byyFNomr5n+ya2WdFAnrZypRD3L29o2vA29Y5Is
         BOpdFCdcLkdarMs0H5A4EhSW3R+L5Yg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000007,0.005504)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.071756), Hit: No, Details: v2.40.0; Id: 15.52k0tm.1g63emviq.1fdrp; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 21 Jun 2022 18:39:48 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, corbet@lwn.net
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v21 5/5] MAINTAINERS: add Microchip PolarFire FPGA drivers entry
Date:   Tue, 21 Jun 2022 18:38:47 +0300
Message-Id: <20220621153847.103052-6-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621153847.103052-1-i.bornyakov@metrotek.ru>
References: <20220621153847.103052-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add MAINTAINERS entry for the newly added Microchip PolarFire (MPF) FPGA
manager. Add myself as a reviewer and Conor Dooley as a maintainer.

Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b774f21828f7..ed2517574804 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7884,6 +7884,14 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
 F:	drivers/fpga/intel-m10-bmc-sec-update.c
 
+MICROCHIP POLARFIRE FPGA DRIVERS
+M:	Conor Dooley <conor.dooley@microchip.com>
+R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
+L:	linux-fpga@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
+F:	drivers/fpga/microchip-spi.c
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
-- 
2.25.1


