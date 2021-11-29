Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC70461B9C
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Nov 2021 17:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbhK2QQB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Nov 2021 11:16:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57628 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbhK2QOA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Nov 2021 11:14:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D40DF61571;
        Mon, 29 Nov 2021 16:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD67C53FC7;
        Mon, 29 Nov 2021 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638202242;
        bh=QCSCNQAEJNPVIfuhwv4nMqQDWjQzAgnwlTOu2L9UYI0=;
        h=From:To:Cc:Subject:Date:From;
        b=PCvu5olrO6CrIe+HUaQ/GSC7b8Pqtn+EzPcOb+UhipT1ERV0yNe9vHACtLaFe1UAn
         K13YBIKV2+sdvPo8o7nJhYi1bjURnSwGEzrjkYiIof0QPhbjcVKxHmbMDI5pMsbW7H
         QX6fAuJ7fVPqvJE6qw1UlyMst2pUPRU48KAEBSbnMasMQeUyqSd9youfcW2+jKVp+A
         R37BbGyTFNfbnETHWftsZtn3fYoGszPQiEPwkq7CU3rVY2MtZUDUpVzxpf1gLSePHb
         kfG3J3TDJxvg6BvnlDIP9iswQKW51SzoZx56ecx8Rr6zfBaYrkFI35hCAGPmR4+rVP
         ieYbnyUIXowag==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] fpga: stratix10-soc: Do not use ret uninitialized in s10_probe()
Date:   Mon, 29 Nov 2021 09:10:09 -0700
Message-Id: <20211129161009.3625548-1-nathan@kernel.org>
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
drivers/fpga/stratix10-soc.c:402:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 warning generated.

ret is only assigned in an error path now so just return 0 directly.

Fixes: 4ba0b2c294fe ("fpga: mgr: Use standard dev_release for class driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1517
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
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

