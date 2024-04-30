Return-Path: <linux-fpga+bounces-523-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EFF8B6829
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Apr 2024 05:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E707E2820A9
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Apr 2024 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA6FDDA6;
	Tue, 30 Apr 2024 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOmkaCUd"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B7101C4
	for <linux-fpga@vger.kernel.org>; Tue, 30 Apr 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446634; cv=none; b=qtDy93D66dPYDaYFYYSRvM3zAzUfeWmwdGYr+eIPQZRtlMjSN9xlGsXatAvzAeL8kiIf26OIGhu0h1YRGkJivrnqCcBbIc5o4G7v0UPzBCOIO6AFuHkZiXd0C1rs6mJ//Kd1KhHSiMlDBNDjawVpEZjLQdaW6G3yqMqJuYfNf5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446634; c=relaxed/simple;
	bh=UkjMtG6cSlvY8xJgHWQlDFSQopP6uHYif40hKxJIBj4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UZt4ANcvz7xOZ1KyM14FETlJagC1Iz70kCTc8sflgslMFcziwrYvX5qsQQ9sDtRCruPeEJLsqDTEzoGPaFdcnkLNyIfAN8/pY6xinkGrpAmCu9OvvR4ygbULHu5ABmNndc4Us4muwzaEg9MzaHamwJKk2P9ly4Bs5v/IFPn4ESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOmkaCUd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714446633; x=1745982633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UkjMtG6cSlvY8xJgHWQlDFSQopP6uHYif40hKxJIBj4=;
  b=HOmkaCUdvhE27al55q38NeYonm5EMz78AswJ/aftW+jc4JtnuHP7aXNx
   966DETAoYxHUbxnRT1cBdxw7GBtI79OuiPc4+lddhKqD5ooYkZlrosFGU
   i+a2a+i1sV7l1OPlhwfiKrRy7gS7vW3P92O1szr1ZwxEl8AdpGXa9WaCd
   ysjNbl/CDAlC9k1+UdNaej1DE3J/T9M6015hownReGElicJEtjmewfhF1
   f/gmYOsjRM2I8UgFTTqeiaGH5odgVSP36YyJxBRoIlMr0J0fGFC+TRJYx
   KLhMDJrQFU1CYg1onYJSx99TT/x6z3d3vX/IUIag1zuDSyvthGRf3HYyx
   A==;
X-CSE-ConnectionGUID: v9aHdF8vR7y6RVv8IycRjw==
X-CSE-MsgGUID: Iu28fdZQRAWRiJh2qfBjYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21549055"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21549055"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:10:32 -0700
X-CSE-ConnectionGUID: J/ZwFeSdS4uPebOkdhaNxg==
X-CSE-MsgGUID: /56DHDR7TOecoARhdNj2sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26932492"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 29 Apr 2024 20:10:30 -0700
Date: Tue, 30 Apr 2024 11:05:01 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.9 final
Message-ID: <ZjBf3XLBKXFZMhoc@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.9-final

for you to fetch changes up to bb1dbeceb1c20cfd81271e1bd69892ebd1ee38e0:

  fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card (2024-04-26 12:14:28 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.9-final

DFL

- Peter adds PCI ID table for Intel D5005 Stratix 10 FPGA card

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our fixes branch)

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Peter Colberg (1):
      fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card

 drivers/fpga/dfl-pci.c | 3 +++
 1 file changed, 3 insertions(+)

