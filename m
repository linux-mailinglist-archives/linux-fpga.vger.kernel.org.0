Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265DC1C99B0
	for <lists+linux-fpga@lfdr.de>; Thu,  7 May 2020 20:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgEGSsa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 May 2020 14:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgEGSsa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 7 May 2020 14:48:30 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B87724955;
        Thu,  7 May 2020 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877309;
        bh=71KkHS6CWvgF2ZJ7u+HnXKXGjPAZKfm5qx6YYtMLnTw=;
        h=Date:From:To:Cc:Subject:From;
        b=JLkZyB3N4vnxXrFo3L5FiN1MB37vTxsslqhBShcfEL5rIUTeAElYnta0RTMuH0HGd
         eqxRKWN/4X/6iY+An1GAKYyxho06AWLXoUsLbzzbpQx+lPZzs2X5O2ZHsLeHsfW2a1
         XgXtODNFxYJvXtelTpt2r466QcAoHAmpszNM6188=
Date:   Thu, 7 May 2020 13:52:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: dfl: Replace zero-length array with flexible-array
Message-ID: <20200507185256.GA14313@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/fpga/dfl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 9f0e656de720..1cd51ea52ce1 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -235,7 +235,7 @@ struct dfl_feature_platform_data {
 	unsigned long dev_status;
 	void *private;
 	int num;
-	struct dfl_feature features[0];
+	struct dfl_feature features[];
 };
 
 static inline

