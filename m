Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A829319422
	for <lists+linux-fpga@lfdr.de>; Thu,  9 May 2019 23:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfEIVIj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 May 2019 17:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfEIVIg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 May 2019 17:08:36 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34513217F5;
        Thu,  9 May 2019 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436115;
        bh=A2KlR4tg2BhBXTfCzsQuGbwT0RVrYjIIugnnkl+JVAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9wfyHob1Brg0UK3vjRJ8iO/B6s1DMf1UfQ9PMSKL7dp69cF0Rkd9QhEIjt1XlKOJ
         b5qjMdTmzbze1iqYRdK5QOcwBkTq89zZQaSnHYxbsDANuVgLtKtmYaZQlch1b1sSUV
         M6YFWAR7sSb4veSEZJnZ08+XEe28xkLpbVXRfGH4=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Wen Yang <wen.yang99@zte.com.cn>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 1/4] fpga: stratix10-soc: fix use-after-free on s10_init()
Date:   Thu,  9 May 2019 16:08:26 -0500
Message-Id: <20190509210829.31815-2-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509210829.31815-1-atull@kernel.org>
References: <20190509210829.31815-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

The refcount of fw_np has already been decreased by of_find_matching_node()
so it shouldn't be used anymore.
This patch adds an of_node_get() before of_find_matching_node() to avoid
the use-after-free problem.

Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/stratix10-soc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 13851b3d1c56..215d33789c74 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -507,12 +507,16 @@ static int __init s10_init(void)
 	if (!fw_np)
 		return -ENODEV;
 
+	of_node_get(fw_np);
 	np = of_find_matching_node(fw_np, s10_of_match);
-	if (!np)
+	if (!np) {
+		of_node_put(fw_np);
 		return -ENODEV;
+	}
 
 	of_node_put(np);
 	ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
+	of_node_put(fw_np);
 	if (ret)
 		return ret;
 
-- 
2.21.0

