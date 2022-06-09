Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEEA5451A3
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jun 2022 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbiFIQK7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Jun 2022 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbiFIQKz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 9 Jun 2022 12:10:55 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9892F3004D2;
        Thu,  9 Jun 2022 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=Rj/bc4NLOD6y0lx4o0+8nOenP1BSK87pxbF3KNpnDkc=;
        b=DvD4WUaARrJ7jB+MHzv+O6q7P8K0laOBe4EnuPcL1j5vrCh203QA3GL9vGq5JLZ6cJxAEQB6WtCc3
         grLBr8z2+ipMLhUCrRCiF0s/6BbuUkRFHINHLgefpdqA8I7aRYokhuxgavEKCNTFZE6FiTTcm7kWtw
         w3iLKgRGJbXCyiWDP10uIY8qb8q6vdm675/yO7w23NVW3VofTVJu7KyNOUQ8z3gHresU9oVPeQV/wO
         d0S78+wIOi8xUOtJS33b4S6iUVaLZtzTYyfcsno8h7SgHhv3rUsyuPeCxazEpXdejXm0C7CY0Lfje/
         b01IgiEZe3swehVgB0ILNrFBIQ6EyLg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000011,0.011574)], BW: [Enabled, t: (0.000021,0.000001)], RTDA: [Enabled, t: (0.137038), Hit: No, Details: v2.40.0; Id: 15.52k05u.1g54jmjqq.r1r; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 9 Jun 2022 19:10:30 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, corbet@lwn.net
Cc:     Ivan Bornyakov <brnkv.i1@gmail.com>, Conor.Dooley@microchip.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru, Ivan Bornyakov <i.bornyakov@metrotek.ru>
Subject: [PATCH v17 2/4] docs: fpga: mgr: document parse_header() callback
Date:   Thu,  9 Jun 2022 18:47:50 +0300
Message-Id: <20220609154752.20781-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609154752.20781-1-i.bornyakov@metrotek.ru>
References: <20220609154752.20781-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Document newly introduced fpga_manager_ops callback parse_header() along
with header_size and data_size fields of struct fpga_image_info.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 Documentation/driver-api/fpga/fpga-mgr.rst | 31 ++++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 42c01f396dce..db0852bd3ddc 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -79,14 +79,29 @@ do the programming sequence for this particular FPGA.  These ops return 0 for
 success or negative error codes otherwise.
 
 The programming sequence is::
- 1. .write_init
- 2. .write or .write_sg (may be called once or multiple times)
- 3. .write_complete
-
-The .write_init function will prepare the FPGA to receive the image data.  The
-buffer passed into .write_init will be at most .initial_header_size bytes long;
-if the whole bitstream is not immediately available then the core code will
-buffer up at least this much before starting.
+ 1. .parse_header
+ 2. .write_init
+ 3. .write or .write_sg (may be called once or multiple times)
+ 4. .write_complete
+
+The .parse_header function will set header_size and data_size to
+struct fpga_image_info. If header_size is set, .write function will get image
+buffer starting at header_size offset from the beginning. If data_size is set,
+.write function will get data_size bytes of the image buffer, otherwise .write
+will get data up to the end of image buffer. This will not affect .write_sg,
+.write_sg will still get whole image in sg_table form. If FPGA image is a
+single contiguous buffer, whole buffer will be passed into .parse_header.
+If image is in scatter-gather form, core code will buffer up at least
+.initial_header_size before the first call of .parse_header, if it is not
+enough, .parse_header should set desired size into info->header_size and
+return -EAGAIN, then it will be called again with greater part of image buffer
+on the input.
+
+The .write_init function will prepare the FPGA to receive the image data. The
+buffer passed into .write_init will be at least info->header_size bytes long,
+if it's defined, otherwise .initial_header_size; if the whole bitstream is not
+immediately available then the core code will buffer up at least this much
+before starting.
 
 The .write function writes a buffer to the FPGA. The buffer may be contain the
 whole FPGA image or may be a smaller chunk of an FPGA image.  In the latter
-- 
2.35.1


