Return-Path: <linux-fpga+bounces-1408-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF51C31E2D
	for <lists+linux-fpga@lfdr.de>; Tue, 04 Nov 2025 16:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4144224F6
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Nov 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA61268C42;
	Tue,  4 Nov 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="buH0476G"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp95.iad3a.emailsrvr.com (smtp95.iad3a.emailsrvr.com [173.203.187.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFB2D73A6
	for <linux-fpga@vger.kernel.org>; Tue,  4 Nov 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270610; cv=none; b=bRyO8BIEbj3Ej73OYuctPcR3T5DAe+Kx1ZX+rVZEgnWFzoNWMLGDnnJe29i2jD0rDVgeY7AU2H23xSIGLTtPUsQy7eHahgZF7irD/i0sq8Dq3M/FQ5bPEsIrhCOkXmL+UYnIvd0YiKZ7qEKKgYsojfFiJk2VQWiw9vbzdUO/oMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270610; c=relaxed/simple;
	bh=pMilZKZx2jVf6zyaNURLd3OxiXN16FkOjWdl17Kj8K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKNZkQgxaZzUBnpNkgyoX+GKxKsSrqZgDh7C6EV3dO83qBZIXP6ig2zUx3a0ApXKbXh8GnREIJAq37rUikNIMePDfXZ5QhBIbXXtVmgt1GOywy69tSbkrqyZsSNQH71a8+T+N3OV7LhM8Yo6lAeKn9SsQDIKA3YJyIztr+JkcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=buH0476G; arc=none smtp.client-ip=173.203.187.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762270229;
	bh=pMilZKZx2jVf6zyaNURLd3OxiXN16FkOjWdl17Kj8K8=;
	h=From:To:Subject:Date:From;
	b=buH0476GU7Hcnr7J8cPiUBjcV6wP74cny4l1xQVLXPz3e2sMjvTzaA2fc/KEjS1Cy
	 HUs9H6S2T6GDD02fUvOD+CEjftTKu0jLG9X+CvSIhG3giYDAqGhsISwgUcLi73GXiX
	 etGFK3LKVh5A5JtVB2FZcN34F5NL2PYjtw+c+ksY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 8CC9555B7;
	Tue,  4 Nov 2025 10:30:28 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 1/4] fpga: altera-pr-ip: Add dummy definitions of API functions
Date: Tue,  4 Nov 2025 15:27:02 +0000
Message-ID: <20251104153013.154463-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104153013.154463-1-abbotti@mev.co.uk>
References: <20251104153013.154463-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 7af648e7-5513-437d-9d71-25d484e80853-2-1

Add a dummy definition of alt_pr_register() for build testing.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 include/linux/fpga/altera-pr-ip-core.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
index a6b4c07858cc..4a5aa9adaccc 100644
--- a/include/linux/fpga/altera-pr-ip-core.h
+++ b/include/linux/fpga/altera-pr-ip-core.h
@@ -11,7 +11,13 @@
 #ifndef _ALT_PR_IP_CORE_H
 #define _ALT_PR_IP_CORE_H
 #include <linux/io.h>
+#include <asm/errno.h>
 
+#ifdef CONFIG_ALTERA_PR_IP_CORE
 int alt_pr_register(struct device *dev, void __iomem *reg_base);
-
+#else
+static inline int alt_pr_register(struct device *dev, void __iomem *reg_base)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* _ALT_PR_IP_CORE_H */
-- 
2.51.0


