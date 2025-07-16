Return-Path: <linux-fpga+bounces-1284-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3534B07B99
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Jul 2025 18:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463FA4A0CCB
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Jul 2025 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBFC2F5C34;
	Wed, 16 Jul 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELpJZhmj"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED22F5472
	for <linux-fpga@vger.kernel.org>; Wed, 16 Jul 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685137; cv=none; b=aC9MPCL0quKNPbImghlEM5KzDZVxl3eDU3dqkX8w7hFrAkgOuqg2hRkNFURxvuHqkVhY/Zv04ahtQSk5LCg+ouFJ8rFBl9ERBkmjCSFgYxLqkfJrQx485wBRl/srx+hEU3DnMmSTKfUK5orm7jmEI4glJrxIttqVfI+JJjUQ87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685137; c=relaxed/simple;
	bh=DjMsdWl4Gij4e5CQ5a+/WxiUxD9k24OfyZxnHLkcZgY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZNLgTBq+tV4GtPjK3QMNylL3VCLSzK6e+77WdrYjXIHdKnNRgzanla7Cb7ukcR+Yo7OeiwYIGPu6xZqSzGJCr5q7cKOKj0iRE4S67kbYGHj5RiX9lUCoGZ1MTZqf09naxtwL4lTTDmG2dA2RKmKiukiK6g14PMJBjcOBAX2FMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELpJZhmj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752685136; x=1784221136;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DjMsdWl4Gij4e5CQ5a+/WxiUxD9k24OfyZxnHLkcZgY=;
  b=ELpJZhmj9cKNT8aJG7iO9sqV9EakixW6dCd1SPLM9h1u3YaHC8up8ps1
   AEb4deRxtjImHpZlFJQtgcsvnxhL629bHg3X3mgD6v0hmfS+zC6C85Fit
   Jm1/LmYQLKa/v8ZIsQpeeNlidQ/1059KxwU5bSBMaB1pjOwAPS0sIBebF
   fvY2mhDPlPJdJaDv8PXVB6cuOGl+g9ZfDPRgL5TO6mMbfpr6DhlWUq9f5
   9FCP1QwxBQK1id7pE4NZ8yutJFM3xlaag9pCWDg4/O+XEbnt5/HpBI/Cf
   oBx9LDsR5hvig5ll4KgS6SVhlkeUnB8uO4m5hl9oO1rsFJwLAUHOVk1Md
   A==;
X-CSE-ConnectionGUID: d5Kb+7UQQ5WpkEIQ7ZqN1g==
X-CSE-MsgGUID: r48fLlRmRcyOwQ5AoCxCpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54912712"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54912712"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 09:58:55 -0700
X-CSE-ConnectionGUID: WURfUEQvRmSrnkc23hY+pQ==
X-CSE-MsgGUID: mUmgEwsxS8uMF/xvTOARUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="194695318"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 16 Jul 2025 09:58:54 -0700
Date: Thu, 17 Jul 2025 00:50:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.17-rc1
Message-ID: <aHfYRyt9KycaroDx@yilunxu-OptiPlex-7050>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.17-rc1

for you to fetch changes up to 37e00703228ab44d0aacc32a97809a4f6f58df1b:

  zynq_fpga: use sgtable-based scatterlist wrappers (2025-06-18 10:36:55 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.17-rc1

- Marek's change fixes the incorrect use of sgtable calls.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Marek Szyprowski (1):
      zynq_fpga: use sgtable-based scatterlist wrappers

 drivers/fpga/zynq-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

