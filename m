Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28BF394500
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhE1P2T (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 May 2021 11:28:19 -0400
Received: from gproxy10-pub.mail.unifiedlayer.com ([69.89.20.226]:34258 "EHLO
        gproxy10-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232852AbhE1P2T (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 May 2021 11:28:19 -0400
X-Greylist: delayed 1265 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 11:28:18 EDT
Received: from cmgw14.mail.unifiedlayer.com (unknown [10.0.90.129])
        by gproxy10.mail.unifiedlayer.com (Postfix) with ESMTP id C97098026576
        for <linux-fpga@vger.kernel.org>; Fri, 28 May 2021 15:05:34 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id me3IlaO9GZwLVme3JluggG; Fri, 28 May 2021 15:05:34 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=NJkQR22g c=1 sm=1 tr=0 ts=60b106be
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=5FLXtPjwQuUA:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=gf_e1fZwN2w3IhSJoCgA:9 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gCTowyJzPhgpERoszzxsntvCrRt6s9voMhvK7mg6YPY=; b=j05R4R0V/CMxQMd3bYYxN1D15I
        9/ne4jbbCzxh5JvbiPehRad0XfHG54qiMCmorIMlAGde0pz1FDftY6X5SFzvAmdDtJrmSWB/vTFlZ
        DuDm2HEbbOxXjvPQpq3GtRBpk6CEEyaWR6utcEUm3AakcHeTSQoYwOK1qz6YR/Oo8rDSAfMc4ZuBr
        Op/6tHs12ou5WhT8yGnQCM+6bITPNB+rcX074H5f7+u2MXSJNJqsMYzyKQIChpEmFyZS1ZK/puIwD
        +BRqrH+FlNiZO6CfkUvzgkKNzTTHSEeV+Pob2SAW3/NhRhDSu6enCMELnqZVZEWuKSO5EaPIQMCYl
        6PN192FQ==;
Received: from [117.202.184.159] (port=43020 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <navin@linumiz.com>)
        id 1lme3H-000YkU-O6; Fri, 28 May 2021 15:05:31 +0000
From:   Navin Sankar Velliangiri <navin@linumiz.com>
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mdf@kernel.org, trix@redhat.com, navin@linumiz.com
Subject: [PATCH] fpga: fpga-bridge: removed repeated word
Date:   Fri, 28 May 2021 20:35:57 +0530
Message-Id: <20210528150557.22970-1-navin@linumiz.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 117.202.184.159
X-Source-L: No
X-Exim-ID: 1lme3H-000YkU-O6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [117.202.184.159]:43020
X-Source-Auth: linumcmc
X-Email-Count: 4
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Removed repeated word and.
Reported by checkpatch.

Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
---
 drivers/fpga/fpga-bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index e9266b2a357f..9ada1126faf7 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
  * @info: fpga image specific information
  * @bridge_list: list of FPGA bridges
  *
- * Get an exclusive reference to the bridge and and it to the list.
+ * Get an exclusive reference to the bridge and it to the list.
  *
  * Return 0 for success, error code from of_fpga_bridge_get() othewise.
  */
@@ -258,7 +258,7 @@ EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
  * @info: fpga image specific information
  * @bridge_list: list of FPGA bridges
  *
- * Get an exclusive reference to the bridge and and it to the list.
+ * Get an exclusive reference to the bridge and it to the list.
  *
  * Return 0 for success, error code from fpga_bridge_get() othewise.
  */
-- 
2.31.1

