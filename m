Return-Path: <linux-fpga+bounces-1023-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C93A22385
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Jan 2025 19:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD58163545
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Jan 2025 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2011DE2DF;
	Wed, 29 Jan 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mW24PutO"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB5190696;
	Wed, 29 Jan 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173702; cv=none; b=U1W2w3ZaMcOykDhQXUVpSilZT0VMeV3zJYdGPH01PCHNsDK6uXjx+xK4wVDcV6lOROFkwVgvD17A/tRBgUCPbD3jMASw3LH+10mtQ/Ca0U+1PtiBjhfG6lQEvB7DzLilINagl3nK0u40N+FrFFbCceI6rJGiP4IeayTXNoobEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173702; c=relaxed/simple;
	bh=YCUyhaRoDJqojgBQgfjgIDWzf44BcOOrli9JHxA0gDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdZpqVWAon/qlxa5xOUmgbozM2LQ2RTz1B03BfshG8qeY5u4za+XZDNU61zrREkRspZpxu/VMmGWIs4QqxZaEctwNx2Glrt4VzpmyCQK2xgt0f6QnRbtjSvvYcpoLvYiHNvMQf7d0dZ4RgSVIec8RAFYpC9MqcQhLxgkqpRMIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mW24PutO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738173701; x=1769709701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YCUyhaRoDJqojgBQgfjgIDWzf44BcOOrli9JHxA0gDg=;
  b=mW24PutOkrrOx3F7OUiOpomr+tDV45ONMqh6Z4yKYmgeJvi5e3FW4Hp7
   2YJjPmNbi3KQAWoLw9cJvQx9C6NZkkux43cqfoAiIOQ1QxQuVRA2puLyQ
   NyoAeZXcn0V+g1URoNmh2rX+N6SbAb+pg/NfLp08c/znG9pUczYKvsEpJ
   0gWdIDLk2BoIpXuWaqNmBrWi95stjwVAikgzOiEI+K8PFYKeysMXxhZZV
   /l0FDTi8ZinRWVFWlMZ1U9HjjrQf3d4SKxrm0d3HDXYpMD9N5VBNVyrr1
   umtnR2guEmEr8SskwQ2wPX4lWjeeU9U6pncsZ4Maf+0E4hQ5IdnZWkS93
   A==;
X-CSE-ConnectionGUID: BpYv2x32RqOv+ZYXHxEaNQ==
X-CSE-MsgGUID: enRa9aqIRAmDG9XjhqJWEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="64063502"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="64063502"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:01:40 -0800
X-CSE-ConnectionGUID: u9qfmyypSEuEfTgWD0qpNw==
X-CSE-MsgGUID: DrMVmwTWSO26RK/SJXpM0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109551745"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by orviesa007.jf.intel.com with ESMTP; 29 Jan 2025 10:01:36 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
To: yilun.xu@linux.intel.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dinguyen@kernel.org,
	hao.wu@intel.com,
	krzk+dt@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mahesh.rao@altera.com,
	mahesh.rao@intel.com,
	mdf@kernel.org,
	robh@kernel.org,
	trix@redhat.com,
	yilun.xu@intel.com
Subject: Re: [PATCH 3/3] firmware: stratix10-svc: Add of_platform_default_populate()
Date: Thu, 30 Jan 2025 02:01:13 +0800
Message-Id: <20250129180113.17219-1-mahesh.rao@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <Z5XyR9QE3kcQDOPe@yilunxu-OptiPlex-7050>
References: <Z5XyR9QE3kcQDOPe@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yilun,
Thanks for reviewing the patch.

On Sun, 26 Jan 2025 16:28:55 +0800, Xu Yilun wrote:
> > Add of_platform_default_populate() to stratix10-svc driver as the
> > firmware/svc node was moved out of soc.
> > This fixes the failed probing of child drivers of svc node.
> >
> > Fixes: 23c3ebed382a ("arm64: dts: socfpga: agilex: move firmware out
> > of soc node")

> > +	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
> > +	if (ret < 0) {
> 
> 	if (ret)  is just fine.

ok ,I will make the change.

> 
> > +		of_platform_depopulate(dev);
> > +		goto err_unregister_fcs_dev;
> 
> You wanna destroy everything even if some child drivers work?

Currently, there is no requirement to retain the driver if a child component fails.
we will handle it if it is needed in the future.

> And do we need to do depopulation on driver remove?

I think yes , I have missed this. I will add depopulate in the remove callback().

> I'm actually a little confused how to handle populate() fail and depopulate().

I think this was a mistake on my side. I will make the change in next revision.

Best Regards,
Mahesh Rao

