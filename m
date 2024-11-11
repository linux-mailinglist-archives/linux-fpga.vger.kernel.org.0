Return-Path: <linux-fpga+bounces-926-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B57C9C3719
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Nov 2024 04:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC31728169D
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Nov 2024 03:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D09C145B18;
	Mon, 11 Nov 2024 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVrAERUY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A711BF58
	for <linux-fpga@vger.kernel.org>; Mon, 11 Nov 2024 03:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731296660; cv=none; b=b9i7JQL9M0gGqL5f3EkinxmZx6tGsg4g0m6xxU0MuB++A8wvE8N7EK+q8PqIZPzt2SwEJVEY56YfvyBSj6RY4ieTJ++I2S1ZLcnrsKK8zA5qpJEE6B/cK/FisIDXr+cnNHle0/Wc0A4+2d1M5QU2FJW10mfeEWXHtTTa7a2MIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731296660; c=relaxed/simple;
	bh=kxy3+OAGEOQbc7nXDJEUlFT+3NVwf6glvRd1Jw14SqI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HotBUSFdAgZLo+WGh+MxgLpbnA8DD8+kh4Cod1btN7u3A8ImXpJh0iJu40S+UGIL1geScsVgZcf7hoIQzbFcfwE2yNQzCZf1jJkPJV5M3fYqCQHp0P5K++C9zIrvQwulQs7KETpV9vVIBp8QKeDQf5Xw/up89RPcq1OtO1BWBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVrAERUY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731296658; x=1762832658;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kxy3+OAGEOQbc7nXDJEUlFT+3NVwf6glvRd1Jw14SqI=;
  b=RVrAERUY4j9Q+Q/5m+mF6+pMl3FWW5YPFdeXSsCdZIm33JM7TF/XlfFh
   neEUNDtLRmawAd2yQu/RNmMdO1Ay3fY7kKQBJjUOEVVuPLhACQZlNl8m+
   Dkh4psKzVy7G8uDFQzc7K0nRFyy8FzqtpQw2NA8ZOhwBUKZBEuOqysyIp
   AmXaB5XoNzFnHJF6qx+pl88rhHKEZ/ivRdQUNiAi0trxTFMy9AlSeytnU
   JOuH3dbvbIgtvSoZWKSbtxfrwwmD3NtOQsUPjiZunDnXafkNuqasTHGnU
   TQEuc4Vwd3f/XjSDM+CQ7qvcNWsYUsnnldR6W9yOQZvCsu3V6ljAo8CX0
   g==;
X-CSE-ConnectionGUID: Olx/fToEQqKUn0blwXophA==
X-CSE-MsgGUID: 4oBGbjyyQ0iXlomk6Y+fLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="30507974"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="30507974"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 19:44:18 -0800
X-CSE-ConnectionGUID: 8YMgHDvtQymWB8g/cwcs4Q==
X-CSE-MsgGUID: +68/HIHBQfG9iSaBexhZKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="91645197"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 10 Nov 2024 19:44:16 -0800
Date: Mon, 11 Nov 2024 11:40:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.13-rc1
Message-ID: <ZzF8revoFulyrG7F@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.13-rc1

for you to fetch changes up to dbbd975cc6df04c375f01e19b13ec52e4d2408ba:

  fpga: Switch back to struct platform_driver::remove() (2024-11-11 10:43:21 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.12-rc1

- Uwe's change switch back to use platform_driver::remove()

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Uwe Kleine-König (1):
      fpga: Switch back to struct platform_driver::remove()

 drivers/fpga/altera-fpga2sdram.c        | 2 +-
 drivers/fpga/altera-freeze-bridge.c     | 2 +-
 drivers/fpga/altera-hps2fpga.c          | 2 +-
 drivers/fpga/dfl-afu-main.c             | 8 ++++----
 drivers/fpga/dfl-fme-br.c               | 8 ++++----
 drivers/fpga/dfl-fme-main.c             | 8 ++++----
 drivers/fpga/dfl-fme-region.c           | 8 ++++----
 drivers/fpga/intel-m10-bmc-sec-update.c | 2 +-
 drivers/fpga/of-fpga-region.c           | 2 +-
 drivers/fpga/socfpga-a10.c              | 2 +-
 drivers/fpga/stratix10-soc.c            | 2 +-
 drivers/fpga/xilinx-pr-decoupler.c      | 2 +-
 drivers/fpga/zynq-fpga.c                | 2 +-
 13 files changed, 25 insertions(+), 25 deletions(-)

