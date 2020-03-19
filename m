Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4201418C275
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Mar 2020 22:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgCSVpR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 Mar 2020 17:45:17 -0400
Received: from gateway30.websitewelcome.com ([192.185.197.25]:15756 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbgCSVpR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 19 Mar 2020 17:45:17 -0400
X-Greylist: delayed 1400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 17:45:16 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 7D9B26A80
        for <linux-fpga@vger.kernel.org>; Thu, 19 Mar 2020 16:21:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id F2bzjFN1VSl8qF2bzjo1Xp; Thu, 19 Mar 2020 16:21:55 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Lubcu7p0qfGphDMpjrbgJu8a1pa8xGkLK9eIEZ6nuRE=; b=u6VBBB0zwTk1t5B8lmsQdzWIvV
        jsu7bhh3MomcXnRm7BVvH47RKt2VyGZheMSu92HRuJUYF8GA2shFL74mSzw6IHrVsxq46gELjwXMj
        ePx+t71k5fpmvkjeW8Ii5WjZxHuZUPc03LePlVEMPGb+yZMSRvFB3HPXSSZvHsAY5X0AxDHT/a01u
        pD9YZCOPrL9GEJvqWtI6HIp69oEyUpHIbu2VBjYqcJWwAs4DpAzEsqypS02XUynOWxjwUXQ0QksiQ
        DAiLd4WgnQLJuhMaplriSA/hZNKczV1q6G+hAlAgk9SuFK0ithmy/E8b4fOptnwpsDoRu94x635/m
        k1CO2F0g==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:53266 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jF2bx-001YAh-Vj; Thu, 19 Mar 2020 16:21:54 -0500
Date:   Thu, 19 Mar 2020 16:21:53 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] fpga: dfl.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200319212153.GA5093@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jF2bx-001YAh-Vj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:53266
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/fpga/dfl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 4a9a33cd9979..74784d3cfe7c 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -235,7 +235,7 @@ struct dfl_feature_platform_data {
 	int open_count;
 	void *private;
 	int num;
-	struct dfl_feature features[0];
+	struct dfl_feature features[];
 };
 
 static inline
-- 
2.23.0

