Return-Path: <linux-fpga+bounces-1065-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64FCA480D2
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Feb 2025 15:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFBD3A172E
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Feb 2025 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D702233D93;
	Thu, 27 Feb 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh8Dnmrz"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58F233D64;
	Thu, 27 Feb 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665879; cv=none; b=pIO/c/r1OpWzNsq1O0I2mkDPBfUDZV/ZuHncO9Gmq4Imvm3Hjpgx98YoYuv8Erkvauk/L8avhb9T3LErufpLudOAbFameuEc5TGG9pGfTpiSFiYjSibr8DG4gabvrtveZxr6E5jH2vsSw86RFP0hAw0Cdj3NJtRJJpjTYfdthsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665879; c=relaxed/simple;
	bh=gyR+0JxDx9CPzhusE3qvrKMnhe9hQirZQUCl/pzcCfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F3g3QK3KzFWqPgAcNtdKcno97HRwPHyzWTZpx801ws2lN5GyOY6lBApO3fqRPHpIitEsbAZu/W6whA7B4TTh/gBOW28snn8qm+8DPy7C+5poJBbqFRCg4/PSHBkHiQoygWy9i3cwWCABR9STYrGvU9JsZOxyU7x4BL4F0+4SpZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh8Dnmrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56919C4CEDD;
	Thu, 27 Feb 2025 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740665878;
	bh=gyR+0JxDx9CPzhusE3qvrKMnhe9hQirZQUCl/pzcCfw=;
	h=From:To:Cc:Subject:Date:From;
	b=nh8Dnmrzn7XEchhAjP3eClzJh4utXeaFC3LucBXwMr37WV4b+qfqnHxTyICJYc83/
	 9WJjP4dK9ORAtgZVF4rRvvUHn9XQTJ8YqJqsN9XHE3hlHkB5oDrw7m+vecjOJDu0oG
	 FNCJI3H58WVgXaI4RxT2FaK58CCAIM7ncn4HHGn7/evJF9Nb7NVJZG38vJ/KEP0Tq3
	 2YxvW12wwrYXzZTe1HO9kutTbw/dq6W8Otj/OGHR740U1LvOOSnj93J5xppDYCBSPK
	 kSbFfWaJ1tqtho6RU5yxjjGs+Uxob74/wPsa4hWFpgKbJJMyP9Tbnr70ganj8hyaJQ
	 XZYNzGXUDJwjw==
From: Arnd Bergmann <arnd@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tianfei Zhang <tianfei.zhang@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Calvin Owens <calvin@wbinvd.org>,
	Philipp Stanner <pstanner@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [PATCH] RFC: ptp: add comment about register access race
Date: Thu, 27 Feb 2025 15:17:27 +0100
Message-Id: <20250227141749.3767032-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

While reviewing a patch to the ioread64_hi_lo() helpers, I noticed
that there are several PTP drivers that use multiple register reads
to access a 64-bit hardware register in a racy way.

There are usually safe ways of doing this, but at least these four
drivers do that.  A third register read obviously makes the hardware
access 50% slower. If the low word counds nanoseconds and a single
register read takes on the order of 1µs, the resulting value is
wrong in one of 4 million cases, which is pretty rare but common
enough that it would be observed in practice.

Link: https://lore.kernel.org/all/96829b49-62a9-435b-9e35-fe3ef01d1c67@app.fastmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Sorry I hadn't sent this out as a proper patch so far. Any ideas
what we should do here?
---
 drivers/net/ethernet/xscale/ptp_ixp46x.c | 8 ++++++++
 drivers/ptp/ptp_dfl_tod.c                | 4 ++++
 drivers/ptp/ptp_ocp.c                    | 4 ++++
 drivers/ptp/ptp_pch.c                    | 8 ++++++++
 4 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/xscale/ptp_ixp46x.c b/drivers/net/ethernet/xscale/ptp_ixp46x.c
index 94203eb46e6b..e9c8589fdef0 100644
--- a/drivers/net/ethernet/xscale/ptp_ixp46x.c
+++ b/drivers/net/ethernet/xscale/ptp_ixp46x.c
@@ -43,6 +43,10 @@ static u64 ixp_systime_read(struct ixp46x_ts_regs *regs)
 	u64 ns;
 	u32 lo, hi;
 
+	/*
+	 * Caution: Split access lo/hi, which has a small race
+	 * when the low half overflows while we read it.
+	 */
 	lo = __raw_readl(&regs->systime_lo);
 	hi = __raw_readl(&regs->systime_hi);
 
@@ -61,6 +65,10 @@ static void ixp_systime_write(struct ixp46x_ts_regs *regs, u64 ns)
 	hi = ns >> 32;
 	lo = ns & 0xffffffff;
 
+	/*
+	 * This can equally overflow when the low half of the new
+	 * nanosecond value is close to 0xffffffff.
+	 */
 	__raw_writel(lo, &regs->systime_lo);
 	__raw_writel(hi, &regs->systime_hi);
 }
diff --git a/drivers/ptp/ptp_dfl_tod.c b/drivers/ptp/ptp_dfl_tod.c
index f699d541b360..1eed76c3a256 100644
--- a/drivers/ptp/ptp_dfl_tod.c
+++ b/drivers/ptp/ptp_dfl_tod.c
@@ -104,6 +104,10 @@ static int coarse_adjust_tod_clock(struct dfl_tod *dt, s64 delta)
 	if (delta == 0)
 		return 0;
 
+	/*
+	 * Caution: Split access lo/hi, which has a small race
+	 * when the low half overflows while we read it.
+	 */
 	nanosec = readl(base + TOD_NANOSEC);
 	seconds_lsb = readl(base + TOD_SECONDSL);
 	seconds_msb = readl(base + TOD_SECONDSH);
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index b651087f426f..cdf2ebe7c9bc 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -1229,6 +1229,10 @@ __ptp_ocp_gettime_locked(struct ptp_ocp *bp, struct timespec64 *ts,
 		sts->post_ts = ns_to_timespec64(ns - bp->ts_window_adjust);
 	}
 
+	/*
+	 * Caution: Split access to nanoseconds/seconds, which has a small
+	 * race when the low half overflows while we read it.
+	 */
 	time_ns = ioread32(&bp->reg->time_ns);
 	time_sec = ioread32(&bp->reg->time_sec);
 
diff --git a/drivers/ptp/ptp_pch.c b/drivers/ptp/ptp_pch.c
index b8a9a54a176c..a90c206e320b 100644
--- a/drivers/ptp/ptp_pch.c
+++ b/drivers/ptp/ptp_pch.c
@@ -147,6 +147,10 @@ static u64 pch_systime_read(struct pch_ts_regs __iomem *regs)
 {
 	u64 ns;
 
+	/*
+	 * Caution: Split access lo/hi, which has a small race
+	 * when the low half overflows while we read it.
+	 */
 	ns = ioread64_lo_hi(&regs->systime_lo);
 
 	return ns << TICKS_NS_SHIFT;
@@ -154,6 +158,10 @@ static u64 pch_systime_read(struct pch_ts_regs __iomem *regs)
 
 static void pch_systime_write(struct pch_ts_regs __iomem *regs, u64 ns)
 {
+	/*
+	 * This can equally overflow when the low half of the new
+	 * nanosecond value is close to 0xffffffff.
+	 */
 	iowrite64_lo_hi(ns >> TICKS_NS_SHIFT, &regs->systime_lo);
 }
 
-- 
2.39.5


