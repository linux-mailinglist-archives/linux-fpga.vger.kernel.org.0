Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206A6464122
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Nov 2021 23:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbhK3WRP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Nov 2021 17:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbhK3WQM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Nov 2021 17:16:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6033FC061574;
        Tue, 30 Nov 2021 14:12:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27361B81D4D;
        Tue, 30 Nov 2021 22:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDE1C53FCC;
        Tue, 30 Nov 2021 22:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638310368;
        bh=sj+juij8tw8fLPSN/HlEtchRwvDaEZoWU3Wva1iHMa4=;
        h=From:To:Cc:Subject:Date:From;
        b=fZYPSmoDx9WNAQdony9+f8LbapGKHNkQ8z1MWlpBSBYZ5K1nFaR6IVeEBUBqznUvl
         R9CkI1ujjgwtn5r8CyYAC0Y+vf5x2Awoi1M8EojjD3navAjBnYrDpqB25p6djKzLZf
         ImeqKztcrHL4ONlQeuptJplxMG1I3jwPB663l4WFs1TBtRCDDgK/ExcB7vf+ao/O4Y
         Vus3YvkA9HnBO+0K8KcqnQY4QhMg/XLmlcdGWkUY3eh0YqNhFzHVdUrQWucsbcpd82
         RLt2yrOwMQ8u2TOTvmsXBF4fWsdtCnWExAAC1ebCgU9fJqsHLcisXrlI8QxAwe7UZb
         pJQVTkH7dAV1Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] fpga: stratix10-soc: Do not use ret uninitialized in s10_probe()
Date:   Tue, 30 Nov 2021 15:11:24 -0700
Message-Id: <20211130221123.3800420-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Clang warns:

drivers/fpga/stratix10-soc.c:431:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
        return ret;
               ^~~

ret is only assigned in an error path now so just return 0 directly.

Fixes: 4ba0b2c294fe ("fpga: mgr: Use standard dev_release for class driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1517
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2: https://lore.kernel.org/r/20211129161009.3625548-1-nathan@kernel.org/

* Drop clang's suggestion text (Tom).

* Pick up Russ and Tom's review tags.

 drivers/fpga/stratix10-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 737d14c6e0de..357cea58ec98 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -428,7 +428,7 @@ static int s10_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, mgr);
-	return ret;
+	return 0;
 
 probe_err:
 	stratix10_svc_free_channel(priv->chan);

base-commit: 8886a579744fbfa53e69aa453ed10ae3b1f9abac
-- 
2.34.1

