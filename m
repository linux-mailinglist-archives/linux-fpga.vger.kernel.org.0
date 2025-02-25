Return-Path: <linux-fpga+bounces-1064-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6F5A44641
	for <lists+linux-fpga@lfdr.de>; Tue, 25 Feb 2025 17:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5201B19E129B
	for <lists+linux-fpga@lfdr.de>; Tue, 25 Feb 2025 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562418DF81;
	Tue, 25 Feb 2025 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBMZ0N4F"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B614A60A;
	Tue, 25 Feb 2025 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501316; cv=none; b=ubOtFaAPNl8gSPFDOoITKtFvwOalulis3mrYyCI6mCs/OhrcXvgYr0lHV4ip5NPCBwuJPn1NWVTsHoL78OKjNUxCl1XTjhDrjw2+s0amZsHEhyLeKYKYQFgp7+fuJiJQ+PzSlLZ0WqWyzBHQE3XC2qQAvz+TnmRxC+fXa42v4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501316; c=relaxed/simple;
	bh=a7h//D5zFCNczP69qRlcaU4OGtGn78OQb4RH8hZvmkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmdKsl8QnXCD/qbNkEwK5+KzH/aGT8rETj5RCwgF3h3mPjPlbYE8xsdEx7wdREuyv2JN0jzik3A1ibzAhrRFlZMk96lI9Veq2G8A9nq4eoQIUw9MlxHeOsXk8uLb/sW5TkXFVy3EXj02AOaThL6XXlpCgYJc+dwdsG8YxtR8n1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBMZ0N4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AD4C4CEDD;
	Tue, 25 Feb 2025 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501314;
	bh=a7h//D5zFCNczP69qRlcaU4OGtGn78OQb4RH8hZvmkw=;
	h=From:To:Cc:Subject:Date:From;
	b=YBMZ0N4Fhtw7T/wpgVYj7XMeaJsEDRW75EuIPQW/BLDgJPi+U2zRtBsBZMpEMZXzq
	 fHCVA5Beg7I/totxJmMk6j528a+avt/sDNT5P75Q3isOPEx2X8naM6X1woRYYw1tXs
	 Antf+9mFOmlXl9StxePzB0KKRNq4hclmesEtATlvudAQ4HfazuTQJf5VaCW5y9oa8Y
	 NWiZQ5r13OnaQUoYQoiwzirN1n3uzVSUs322u2AFphDaSKLr473tfUHXvBMRbogeZo
	 JyFcLgdcF1HjM9T16X6U3ZVeCnWp67s4IqAih2dK5WBvYFBcrQbQKWlidnYKd+L/Eu
	 v9/zlH4jxTgpQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: versal: remove incorrect of_match_ptr annotation
Date: Tue, 25 Feb 2025 17:35:07 +0100
Message-Id: <20250225163510.4168911-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a warning about versal_fpga_of_match being unused when
CONFIG_OF is disabled:

    drivers/fpga/versal-fpga.c:62:34: error: unused variable 'versal_fpga_of_match' [-Werror,-Wunused-const-variable]

Acked-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/fpga/versal-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
index 3710e8f01be2..e6189106c468 100644
--- a/drivers/fpga/versal-fpga.c
+++ b/drivers/fpga/versal-fpga.c
@@ -69,7 +69,7 @@ static struct platform_driver versal_fpga_driver = {
 	.probe = versal_fpga_probe,
 	.driver = {
 		.name = "versal_fpga_manager",
-		.of_match_table = of_match_ptr(versal_fpga_of_match),
+		.of_match_table = versal_fpga_of_match,
 	},
 };
 module_platform_driver(versal_fpga_driver);
-- 
2.39.5


