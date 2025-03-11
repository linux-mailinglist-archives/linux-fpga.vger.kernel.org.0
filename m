Return-Path: <linux-fpga+bounces-1101-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DA1A5B664
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Mar 2025 02:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E82217278A
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Mar 2025 01:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D5D1DE2DF;
	Tue, 11 Mar 2025 01:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgnAUbJS"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599FF1E500C
	for <linux-fpga@vger.kernel.org>; Tue, 11 Mar 2025 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741658257; cv=none; b=hBIJtCbRVZYIbCKpaWtOU3NN0r5ReJh4q0WcEiaB7bTsa+gwPyhLxtbujM5HLzDrrgThx+24ZXVS8oQAqMZlyMth3fyKHeT/w+YmAa8G450Ei3Oztc6BiGAI9I6OwhisXHDAV3GTz1m6r3atrT6isIZiUhTKl3nEmP+TX9r0Dbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741658257; c=relaxed/simple;
	bh=3ndEN7SRs9ogSc7ddNZILp/ZpOE5JPQULN8D7Z241Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SfLYSeav5BDfLN6XiWwgkSp9Hk8yLfvbRHISfJqzC4GL9bm3N4bOoN4J/iRM7TWPr4ZwCXhQuC5AwWxxsCPDbovPcRnU79j33qOu7Y0uGsbUkq8SI18JQkLQhwGslakT2eVg/3v3GsYCF5PXDn02yABCP0m7ZiMIhqoBZgZQMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgnAUbJS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741658256; x=1773194256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3ndEN7SRs9ogSc7ddNZILp/ZpOE5JPQULN8D7Z241Mw=;
  b=MgnAUbJSN1iYvPR9M4dIVfXQqftDjbOAHi20XMeetHYbhWrKdZjAzKa2
   83F15e8HUlU78xLhq8e0kIe6VH+cxJSFZmcTwY7YUeG6jRp+AeLU3a5PW
   fsSxO5Xo1jZfywc1ZAGblAoZWjDE/LPWzThlNvf3nXbzisFlrDob2mgRJ
   ZQ4e1HLNLIgadw9J+lOZGeO5YELWUoLAp7TCGqnA/CE7M/h0E2VeBOASe
   EAz7d2ZsgHQseWJa+x4Io6cvkByLhh0Ax5UQaU8GyZwPokq0dZFGEDY63
   2TwWJiXqj6JMfLxqdmcxttkCp3MR7Yz62VninsHpMRuFolaM5b6wBwN3C
   w==;
X-CSE-ConnectionGUID: SsuQc8mHSi6X8E5n3yabHA==
X-CSE-MsgGUID: rawYCWxlQ9q3DOsTBQSRTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42893815"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="42893815"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 18:57:35 -0700
X-CSE-ConnectionGUID: XGejP0BfSo6BKzNDy477Ew==
X-CSE-MsgGUID: A9HXiFPWTFuize4i7WPqkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="151139827"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 10 Mar 2025 18:57:33 -0700
Date: Tue, 11 Mar 2025 09:55:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.15-rc1
Message-ID: <Z8+X+gHZjyvbP6cc@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.15-rc1

for you to fetch changes up to e19890a0088b5884cb9e6a6f5717dc56cc45fc31:

  fpga: versal: remove incorrect of_match_ptr annotation (2025-03-01 17:37:31 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.15-rc1

- Peter's change updates his email address.
- Kuhanh's change increases timeout for altera-cvp driver
- Arnd's change removes incorrect of_match_ptr

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Arnd Bergmann (1):
      fpga: versal: remove incorrect of_match_ptr annotation

Kuhanh Murugasen Krishnan (1):
      fpga: altera-cvp: Increase credit timeout

Peter Colberg (1):
      fpga: m10bmc-sec: update email address for Peter Colberg

 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc       |  4 ++--
 .../ABI/testing/sysfs-driver-intel-m10-bmc-sec-update      | 14 +++++++-------
 MAINTAINERS                                                |  2 +-
 drivers/fpga/altera-cvp.c                                  |  2 +-
 drivers/fpga/versal-fpga.c                                 |  2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

