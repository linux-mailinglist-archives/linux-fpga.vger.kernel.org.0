Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FFA57B5B1
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Jul 2022 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbiGTLhX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Jul 2022 07:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbiGTLhW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 20 Jul 2022 07:37:22 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C46576FA3F;
        Wed, 20 Jul 2022 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5g0TE
        sd2zgx3VT7R/DWP0B1g9HoHFdPqlSi6R68jJtc=; b=IZX1YK7fT8wCzzZBCdyQG
        30Nhj1rojl8532d1GBMTx1pS8B8OgLsk5CRRhvHASY6sBhRmRAdlz0DreiSwqz/f
        P+lR+oO7lfzioqcQhRP7DAGvUMqlik3OTkF6H9TTrXE3DEkbxyY/XIlt29v435JP
        Q+RXTOoCoCMh+YS+W6wceA=
Received: from localhost.localdomain (unknown [112.97.48.93])
        by smtp2 (Coremail) with SMTP id GtxpCgAnsuzh6Ndi0MfGQA--.202S2;
        Wed, 20 Jul 2022 19:37:08 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] dt-bindings: fpga: Fix typo in comment
Date:   Wed, 20 Jul 2022 19:37:04 +0800
Message-Id: <20220720113704.18185-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgAnsuzh6Ndi0MfGQA--.202S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWkAF4UWw4kJrW7tw1UJrb_yoWfZrg_uF
        4IyF18ua1YqFyFgF43Zrn8Z343KF4fCrs3C3WkJwn8t3y09r9I9F97Jwn8ArWUur4Uurnr
        urs7GrWUu3sFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRE1v35UUUUU==
X-Originating-IP: [112.97.48.93]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAwZEZGB0Lmz3rAAAso
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 Documentation/devicetree/bindings/fpga/fpga-region.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 7d3515264838..6694ef29a267 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -330,7 +330,7 @@ succeeded.
 
 The Device Tree Overlay will contain:
  * "target-path" or "target"
-   The insertion point where the the contents of the overlay will go into the
+   The insertion point where the contents of the overlay will go into the
    live tree.  target-path is a full path, while target is a phandle.
  * "ranges"
     The address space mapping from processor to FPGA bus(ses).
-- 
2.25.1

