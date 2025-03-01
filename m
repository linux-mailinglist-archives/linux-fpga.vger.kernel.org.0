Return-Path: <linux-fpga+bounces-1073-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C05A4A9A6
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 09:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7541899A9D
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142FC1B6CE5;
	Sat,  1 Mar 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5Ezu2g1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A871C5D7A;
	Sat,  1 Mar 2025 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740817350; cv=none; b=Aib0KD72Jg0Zq7R/Eeg/aFGZpwI6P4EtIQUPV8QTr1rGVifGELz+klkAWFqNNV9ZZg+aAdj8/3yaxu2oFJke49yWE9ymDJ79gIyaWxObfaSDkqF/YRxdg0sqASDukwdW6jeNrPsAHbbQ1M3dn+SUEQhMOEblaxK1qpYivmy3oIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740817350; c=relaxed/simple;
	bh=2AqI2EuY7NVPxkStTXdWA7z8+oevSpo1EioJIKsGkGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjS4g/In6acB89+7CgEvTlACyMsgpgmNmsHo7oh9oFZyqkK+NtDuP8LM5s8A8WR3GMnp7pRQfufSNXETpWLQeA/0ZBBH6ee2msxKEbFP6ljTqAByWGH9y/nRM6zJ1vI30GhZxxsc6eukb42JJOTwea9lRHCrh1X1DzQps4sIzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5Ezu2g1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740817349; x=1772353349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2AqI2EuY7NVPxkStTXdWA7z8+oevSpo1EioJIKsGkGQ=;
  b=G5Ezu2g1mJJu4cVN4aaKueoT8gGuJbyyG/bGYJizjx6X1ELFOL4jUBix
   JxfMehPi31MGgVuHlhGYh3SuglYoXSfWUkUDUDGMykVYF/oGFquV7yOg9
   /m/S7V2l0zvpesCkBn3pvVOVw7xNKfWwbxrpdDbX4/D0GMz0X3x2RUxFP
   VQrZm73WIbTJrh3qO6yK8I0vZNvcHiF9VkNjjKUkv7Q38qilDKsS3KF8F
   g4FeONWJckXhohTDSCGeNqlfiCjhhMhk57l6WAxno35AGxbd0xtNrqKd2
   4W3vH6VAtdpRkmaZDbdCB6ctUkBlpwLTjS4iVyPKBb4Xx7uturdlgPJ9m
   g==;
X-CSE-ConnectionGUID: 7IP+Ga39QBGFdB/XDoUNjw==
X-CSE-MsgGUID: U70KzJ5OTi2bIxuYHrQtrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="67118666"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="67118666"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 00:22:28 -0800
X-CSE-ConnectionGUID: jhEUoSJ9QlqAWI0ETVZ7wg==
X-CSE-MsgGUID: dDC2vI3/R46y4ccq5eCxMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122781725"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2025 00:22:25 -0800
Date: Sat, 1 Mar 2025 16:20:26 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Hayden Laccabue <hayden.laccabue@amd.com>
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
Message-ID: <Z8LDSjhcXvwnyeiF@yilunxu-OptiPlex-7050>
References: <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
 <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
 <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
 <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
 <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
 <7b9bd24f-8f89-4d6c-a079-47c4c0b88a35@amd.com>
 <Z6WO2Ktc9HoqdUSU@yilunxu-OptiPlex-7050>
 <e68be2e2-7fdd-4f09-b479-4b0e31af5be5@amd.com>
 <Z6sT20uzjes7SGzr@yilunxu-OptiPlex-7050>
 <84281771-52d8-4b1d-8478-1fedb6f31608@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84281771-52d8-4b1d-8478-1fedb6f31608@amd.com>

> My last question for this topic:
> If we decide to upstream both userPF and mgmtPF driver together, could them
> be both within the drivers/fpga/amd as in-tree driver? This will help user

I don't look into your full driver stack. Generally, if your drivers are
all about reprogramming, then yes. If they are also about all kinds of
accelaration functions you'd better split them out in different domains.
I may not have enough knowledge to make them correct.

Thanks,
Yilun

> find source code easily.

