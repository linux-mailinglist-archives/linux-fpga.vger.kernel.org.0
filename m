Return-Path: <linux-fpga+bounces-65-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D22818E27
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937B01C216D7
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34F37D01;
	Tue, 19 Dec 2023 17:32:33 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC537D02
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0005vF-DQ; Tue, 19 Dec 2023 18:32:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxA-0004Gl-8b; Tue, 19 Dec 2023 18:32:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-000CpM-16; Tue, 19 Dec 2023 18:32:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de,
	Peter Colberg <peter.colberg@intel.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/13] fpga: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:31:58 +0100
Message-ID: <cover.1703006638.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2354; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=p2FDldhHGarFlHVQikKRYFZuuHuKpkBZYUP6p3XRNSs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdONdk5oqVmFNsMsm0u9tN70Zj0nVghsutDKX fFyzsq312GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTjQAKCRCPgPtYfRL+ ThVHB/4y9MopoFZuPUfHEJE2CeSSiGAwuMjHW5J0E0XOvy61yfraRGeD4cERSARpvWxUmdII2ta aeNUoqRmwHXO7rwwm5AxV/n8UpS8urofuGHZEcEg6KQQFJqJu6Q54oJngniB5VUcKs6U11ReVUU akYiyzlkQJD8QoxVUyfiscG8DrtVW84m4fSnMXVyhdrH+bxIgE3n5q680CvmIF9b/SiWN7sLrkf Mul3+4zk7YAFU0dw0i1CdNpg7ne1lOWU5xwWFvdQBZE/USGc9c3QKIhF22j4RcpjSZJBvS9zKj7 eZX5lM1V6UyUVB2CQ1AosVWTO14ZdAfC9FmqQQEOd6Aj2cPE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org

Hello,

this series converts all drivers below drivers/fpga to use
.remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
callback that returns no value") for an extended explanation and the
eventual goal. The TL;DR; is to make it harder for driver authors to
leak resources without noticing.

This is merge window material. All patches are pairwise independent of
each other, so they could be applied individually. Getting them all in
together would be nicer though :-)

Best regards
Uwe

Uwe Kleine-König (13):
  fpga: altera-fpga2sdram: Convert to platform remove callback returning void
  fpga: altera-freeze-bridge: Convert to platform remove callback returning void
  fpga: altera-hps2fpga: Convert to platform remove callback returning void
  fpga: dfl-afu-main: Convert to platform remove callback returning void
  fpga: dfl-fme-br: Convert to platform remove callback returning void
  fpga: dfl-fme-main: Convert to platform remove callback returning void
  fpga: dfl-fme-region: Convert to platform remove callback returning void
  fpga: intel-m10-bmc-sec-update: Convert to platform remove callback returning void
  fpga: of-fpga-region: Convert to platform remove callback returning void
  fpga: socfpga-a10: Convert to platform remove callback returning void
  fpga: stratix10-soc: Convert to platform remove callback returning void
  fpga: xilinx-pr-decoupler: Convert to platform remove callback returning void
  fpga: zynq-fpga: Convert to platform remove callback returning void

 drivers/fpga/altera-fpga2sdram.c        | 6 ++----
 drivers/fpga/altera-freeze-bridge.c     | 6 ++----
 drivers/fpga/altera-hps2fpga.c          | 6 ++----
 drivers/fpga/dfl-afu-main.c             | 6 ++----
 drivers/fpga/dfl-fme-br.c               | 6 ++----
 drivers/fpga/dfl-fme-main.c             | 6 ++----
 drivers/fpga/dfl-fme-region.c           | 6 ++----
 drivers/fpga/intel-m10-bmc-sec-update.c | 6 ++----
 drivers/fpga/of-fpga-region.c           | 6 ++----
 drivers/fpga/socfpga-a10.c              | 6 ++----
 drivers/fpga/stratix10-soc.c            | 6 ++----
 drivers/fpga/xilinx-pr-decoupler.c      | 6 ++----
 drivers/fpga/zynq-fpga.c                | 6 ++----
 13 files changed, 26 insertions(+), 52 deletions(-)

base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
-- 
2.42.0


