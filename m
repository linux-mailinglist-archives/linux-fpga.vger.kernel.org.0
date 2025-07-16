Return-Path: <linux-fpga+bounces-1285-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6E5B07BB3
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Jul 2025 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5635D1C40C0E
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Jul 2025 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF82F5491;
	Wed, 16 Jul 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFkr4Xwu"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437352F5C34
	for <linux-fpga@vger.kernel.org>; Wed, 16 Jul 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685208; cv=none; b=ZyBvEpPazi4F14KSQtQidmpdGsYdgpTznpONb9sfoK3V5VzhkcvTxso0AEDbR2VZTFWvDVRIHq6U30EpOIQv82KNvQmW7mF5YTUK8z4zcNJYzOOqqGbynQX9/8yNe7nn+eWTkliR7um96mq5QoF90uj0F84Cw85iaJIml1VVuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685208; c=relaxed/simple;
	bh=4R8huERJWYo5MbgBGFUu7yN4U/RQQ90IWU/zUdsXyvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iN6lHoJB4n7pbQ4vA3PsAfnc/vfaX698/c1H4GTV8v9tWbHe8KdLO1/cZDL7zpJfE8+ujYud8/5CeOVNeCE+UckG2xAuxjtE8vzDEkIT7rnKPjbmPsTrHbZ9II7yO+ktk5RIdQhiiXbXBgt3Y95nyxRxCHqPNJiXYKSN/B4o3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFkr4Xwu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752685206; x=1784221206;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4R8huERJWYo5MbgBGFUu7yN4U/RQQ90IWU/zUdsXyvI=;
  b=BFkr4XwuuYhHuUzIoyhFKfabfRqFy4u+G8hu0qc4XtdXs3DHqCyGvEWf
   LP2smS/XGEgobJX7L20SWyR/xAizBKMUoxStkuaChe9FCTuiCtujF9Te/
   CKzMfJ0v6FkLIzOJA7kLFDQmAcGCd+M0xZma+GAPPiBeXJgLLbSfVrO4S
   92SL7UBlB9EAoOmQnoC+Ej5xbJUeg9FG1qS/QMVq+ZWPV6R5J1XqZ1DVD
   Rvr57MU5JFueWo/pye9kEyY4IhxqQlZ/wGEoXI+MEK46K2JZRTbnONBFT
   PboGmWtzJxctw7uNmVnvoD1t2/NhDfjThbmC5Z0LxG2UOWBn2gSGSGx4a
   Q==;
X-CSE-ConnectionGUID: W/C7/AIpSFCgZqvROOA9YA==
X-CSE-MsgGUID: 7iHX3P5WTVCdiVioZlCehA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55087604"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="55087604"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 10:00:06 -0700
X-CSE-ConnectionGUID: 5I/F3IBRQ4OCpveM5Ldf8g==
X-CSE-MsgGUID: jAFSei7KQRO3OMZ6t0F36A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="163096437"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 16 Jul 2025 10:00:04 -0700
Date: Thu, 17 Jul 2025 00:51:25 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.16-final
Message-ID: <aHfYjZ62LMw2VCCU@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.16-final

for you to fetch changes up to 1c6a132cb30909aba5b37ffc1739f3c288330603:

  MAINTAINERS: Update FPGA MANAGER maintainer (2025-07-12 02:52:40 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.16-final

- FPGA DFL DRIVERS Maintainer change from Wu Hao to Yilun

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our fixes branch)

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Xu Yilun (1):
      MAINTAINERS: Update FPGA MANAGER maintainer

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

