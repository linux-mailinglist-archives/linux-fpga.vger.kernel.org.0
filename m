Return-Path: <linux-fpga+bounces-1283-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555F6B02420
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Jul 2025 20:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF49B6391D
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Jul 2025 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543A1DE2CC;
	Fri, 11 Jul 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MANA7WRI"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F819994F
	for <linux-fpga@vger.kernel.org>; Fri, 11 Jul 2025 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259532; cv=none; b=ECkGI418PmByUqptTO8ouhLTE1vyaTtPsA7D6Hlb90tTSkKOh1llM9kmxYl5iQUXIv72pR4nPe8m5x2VHjdotpPWT4lOmxu2YS0RKXsRwrTP/+8jQvmj6W1RzMmM8Q/lsS0dkVBWSXzITte1/PjbfcTXHvNVipAltczVSih74/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259532; c=relaxed/simple;
	bh=v2LTwxRnMsYSE3B3l8iRObw1/W77VRsAVecLtZdLHLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PIzFfEV7KSd2dV1Gx8aDur6YSiYaO2zj0NlJQVDQAjQtOCdVwCdqzF+Q4eASvR7r9cpy4QaEbFTO1Fm0bIJBH/9ZUPaC8twIXIrDDhF3DBelH8UKF/rJI8lqohZGRWt4HRO13UurzGPs3zHvnw1/xKYR0KtskC/icxm8ozR1usE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MANA7WRI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752259531; x=1783795531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v2LTwxRnMsYSE3B3l8iRObw1/W77VRsAVecLtZdLHLg=;
  b=MANA7WRIVIjNFKJW/GlQqiDCZ9XBX5LmRYV43Y93veMJT0ioFffg/uEp
   CYmApue/qSOPakGLFeMWQq8U1UOdQOP6IyCMn+LYAnJEwFUWX8DvVUEy6
   OP9KTQX4ibegL74ihcsXb9i5tFLOxkwsPnOOgEndXB5PMYYNyaxgcOQsH
   RtTQaS/Bo1R7KBwr8E7vsPCTQynY6K9DlL2JPiTQVR3ZxWw1ZhazMGJgr
   m7vcR4vVd8og6RMNZ0/TXcaGM9UaL4Rb/0pp4frC+3FqK2AKN+lAFc+cE
   UEbwk9Tots/pZ+29cUREUsrAW9zrj2NYZGL7LuSzOxl/AcixBgY99ULYo
   g==;
X-CSE-ConnectionGUID: t388U32IRAaALNCE9EGrYg==
X-CSE-MsgGUID: l/HsZdoSQ3KWw1oQHUZmCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53783806"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="53783806"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:45:30 -0700
X-CSE-ConnectionGUID: 281V9DpCRWKW7TiWW5avxw==
X-CSE-MsgGUID: L4A4uDwmS2iutznC9YC5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="160733754"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 11 Jul 2025 11:45:28 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-fpga@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	mdf@kernel.org,
	dave.hansen@intel.com
Subject: [PATCH] MAINTAINERS: Update FPGA MANAGER maintainer
Date: Sat, 12 Jul 2025 02:37:04 +0800
Message-Id: <20250711183704.1788255-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hao's email no longer works. Remove it from MAINTAINERS. Yilun takes
over his maintainer entry.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..5492f356e675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9421,7 +9421,7 @@ K:	\bunsafe_memcpy\b
 K:	\b__NO_FORTIFY\b
 
 FPGA DFL DRIVERS
-M:	Wu Hao <hao.wu@intel.com>
+M:	Xu Yilun <yilun.xu@intel.com>
 R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
@@ -9434,7 +9434,6 @@ F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
-M:	Wu Hao <hao.wu@intel.com>
 M:	Xu Yilun <yilun.xu@intel.com>
 R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
-- 
2.25.1


