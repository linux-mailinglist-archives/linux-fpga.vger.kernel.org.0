Return-Path: <linux-fpga+bounces-1301-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292C3B1EE10
	for <lists+linux-fpga@lfdr.de>; Fri,  8 Aug 2025 19:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92DF1C27D0A
	for <lists+linux-fpga@lfdr.de>; Fri,  8 Aug 2025 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5571EB5DB;
	Fri,  8 Aug 2025 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDhSFJA5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64378199385;
	Fri,  8 Aug 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675608; cv=none; b=aMiyYbW6VFx6E2X9SFVcVJhpkeGw+n5c/Uqh+M7S+18PLA7QeLi4HnYcpmt6KbhPgvaKEt5bFaQ1Q38NuDQhDpd7ZbuFy36tuR8P1aG9RGYcWvit/gjholnM+FsfXIz34t9bBAKZRYnCzEemrfbHA59fUdhjPwXDGgWKgMgXgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675608; c=relaxed/simple;
	bh=+P4QpmOpqx3Lmn59o8WHoe8drfDVNqCcjJ+/me395jI=;
	h=Subject:To:Cc:From:Date:Message-Id; b=qxeSlaSIAAkanBC9BjJH3qRHt72fsC3+VpZU2bZQYuUzb9DvtkqrCqBLLyMAP/kzi17lCKE90DUHrdFOAGgW9wJ//tJRTeOq2IlLomyc/wcyqPypJZyR0Xhj9UVJl+xdHRlUHyEMcORFcgUfJCr/u5xuzcDN3ci9eIJ3qpAT96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDhSFJA5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754675606; x=1786211606;
  h=subject:to:cc:from:date:message-id;
  bh=+P4QpmOpqx3Lmn59o8WHoe8drfDVNqCcjJ+/me395jI=;
  b=BDhSFJA5bHFGr5qJeBG97rF1gIYfCM9JQp8QfQ8pswU4gT+vWRwjMaw+
   zD+ehwvJnAEy32eZU/9ms/Fj8VdOPMyr9JZxTQPDGK6DATKblKf7CYyHq
   9bf2px5E4kWqPW/ho7bjRPEUV+vY9J+pDt+T/grqDxuHUB/BnNk9U4Vc2
   0tXc/5ai7Qcp4NdwrQlcAGDWoJz9h69OiYHV6BOLQShGBiCWo7O0JAbpZ
   /ZAtwh7H+kuMeohM8gpSE4oI/zVUQA3KjdabdH9RqWXduVck7y7Nu7Ylg
   8MMlDR607JGJD9pT5gfOPBxLskH8Ou9uDdheLOnEinot+Q7EC7oL7vmJC
   w==;
X-CSE-ConnectionGUID: x/d1AdL3RJmzUKnQa8OIfA==
X-CSE-MsgGUID: yarfVb1mQw2pevLd+492gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57158069"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57158069"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 10:53:25 -0700
X-CSE-ConnectionGUID: xfNexg7aRtu4dKWaSemw+g==
X-CSE-MsgGUID: LbnFYWgjQgOg1SYrbOtlgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169588670"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa003.jf.intel.com with ESMTP; 08 Aug 2025 10:53:25 -0700
Subject: [PATCH] MAINTAINERS: Mark Intel PTP DFL ToD as orphaned
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, linux-fpga@vger.kernel.org, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Tianfei Zhang <tianfei.zhang@intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 08 Aug 2025 10:53:24 -0700
Message-Id: <20250808175324.8C4B7354@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This maintainer's email no longer works. Remove it from MAINTAINERS.
Also mark the code as an Orphan.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-fpga@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Tianfei Zhang <tianfei.zhang@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---

 b/MAINTAINERS |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN MAINTAINERS~MAINTAINERS-20250707-8 MAINTAINERS
--- a/MAINTAINERS~MAINTAINERS-20250707-8	2025-08-08 10:49:46.807294387 -0700
+++ b/MAINTAINERS	2025-08-08 10:49:46.823295710 -0700
@@ -12581,10 +12581,9 @@ S:	Supported
 F:	drivers/cpufreq/intel_pstate.c
 
 INTEL PTP DFL ToD DRIVER
-M:	Tianfei Zhang <tianfei.zhang@intel.com>
 L:	linux-fpga@vger.kernel.org
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/ptp/ptp_dfl_tod.c
 
 INTEL QUADRATURE ENCODER PERIPHERAL DRIVER
_

