Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15CCE19425
	for <lists+linux-fpga@lfdr.de>; Thu,  9 May 2019 23:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfEIVIr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 May 2019 17:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfEIVIj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 May 2019 17:08:39 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 191772182B;
        Thu,  9 May 2019 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436118;
        bh=Wy8moiJ/cxkmnT7sGOzk7oIpYpwQsbJLuL5U19+Hoy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7DS+tnpGwvB8LZXcLlEyE65norosYX0q9XnIZvckAyAy327wuNuF2YHZ8AY85XvG
         j5VQ7ZZT6R9++eM9o/xj/xDSd7HK18iX9GRzImQ9vVaNpcCU+Sq26RfwfYE0S00HjH
         VHTJt25dZmFL81UjQ/4xVzpZv4T3/Gfv3XZdncVI=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH 4/4] fpga: dfl: expand minor range when registering chrdev region
Date:   Thu,  9 May 2019 16:08:29 -0500
Message-Id: <20190509210829.31815-5-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509210829.31815-1-atull@kernel.org>
References: <20190509210829.31815-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Chengguang Xu <cgxu519@gmx.com>

Actually, total amount of available minor number
for a single major is MINORMASK + 1. So expand
minor range when registering chrdev region.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c25217cde5ca..4b66aaa32b5a 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -322,7 +322,7 @@ static void dfl_chardev_uinit(void)
 	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++)
 		if (MAJOR(dfl_chrdevs[i].devt)) {
 			unregister_chrdev_region(dfl_chrdevs[i].devt,
-						 MINORMASK);
+						 MINORMASK + 1);
 			dfl_chrdevs[i].devt = MKDEV(0, 0);
 		}
 }
@@ -332,8 +332,8 @@ static int dfl_chardev_init(void)
 	int i, ret;
 
 	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++) {
-		ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0, MINORMASK,
-					  dfl_chrdevs[i].name);
+		ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0,
+					  MINORMASK + 1, dfl_chrdevs[i].name);
 		if (ret)
 			goto exit;
 	}
-- 
2.21.0

