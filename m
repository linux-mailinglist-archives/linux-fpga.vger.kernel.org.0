Return-Path: <linux-fpga+bounces-1018-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F434A1DAA5
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Jan 2025 17:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F553A8CA2
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Jan 2025 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E36152E12;
	Mon, 27 Jan 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/Ub9+g9"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95C149C7D;
	Mon, 27 Jan 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995495; cv=none; b=tJG5KXkEYDehpCK982HShxFSoFWvsdlUq/hAdp9W229gtpS/MgJ5lnh71x1D5N+BYlfz3plKxihxCso7k1zs9CVefI5Eis80HzBrzyyKvj/0tg5yC+4HGKb/yOxFJ337YTWiQyGXLoWpp72FC1NMDa9kGIFxp7X44VHN8//kwBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995495; c=relaxed/simple;
	bh=1DjhvfxtjyVnF9bqJLbWN7eRDHmylbXDmbHfOvhv8kA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lY4SS6v6WWm9bmNN+Q8cEG0hDjpgIU9P9HKhegGVgfVxhP4bqr1+quoGLmu/iBvqFKMqlZSIavHXkjiaIGo/1RfG4d6NPqNDRDm7pNfer2db8g9JzRXJR1ess5MIgtUrqjW3kkQFclzUq5T86djcE3L5zX78seQxw4TN90Xb5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/Ub9+g9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737995494; x=1769531494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1DjhvfxtjyVnF9bqJLbWN7eRDHmylbXDmbHfOvhv8kA=;
  b=e/Ub9+g9D8wPoElkKeoMW794F7lGVJsAoyLNK1dhYvR8cWEDzvujighb
   OB5dqYWBvwbIFOyIUEfE4x1eNorNJlwxHwJbs4JTXWSBtJV4oleB/pRM1
   oYQtiuLd9TNlNSCgxoIrX3qQq7AnPNm0HNNo1QmzqgrPQanmb+W1bdy5f
   DkLxIS5v5S0aud7Dva3IAYzLyly7NMu/rDbHrBGoPDEfXAW6QHtq6w/QQ
   EisRnHkcuqK3Bed4kJAF1HlrMRK53p2JW42bZU6fVyyJYpG3rRi5K7Dxn
   pMo+z0pz6BZjpb5iq6WHFTJv5fvIfkUVaShj5xupVaAp4qndF+magQVS9
   Q==;
X-CSE-ConnectionGUID: W7NnDVn7RR6MjmJCxrValQ==
X-CSE-MsgGUID: 6er5z5d9S6OMktlZMqZ7sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="56003919"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="56003919"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 08:31:33 -0800
X-CSE-ConnectionGUID: WOXF0TtzTH+8nVtcK7xSRg==
X-CSE-MsgGUID: y5CllUwXTTiXsj1EuI+OkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="113513051"
Received: from apgc00009.png.altera.com ([10.244.70.6])
  by orviesa004.jf.intel.com with ESMTP; 27 Jan 2025 08:31:29 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
To: conor@kernel.org
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
Subject: Re: [PATCH 1/3] dt-bindings: fpga: stratix10: Convert to json-schema
Date: Tue, 28 Jan 2025 00:31:01 +0800
Message-Id: <20250127163101.40369-1-mahesh.rao@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250122-duller-headwear-33d84e15a764@spud>
References: <20250122-duller-headwear-33d84e15a764@spud>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Conor Dooley,

Thanks for reviewing the patch.

On Wed, 22 Jan 2025 18:35:51 +0000, Conor Dooley wrote:
> > Convert intel,stratix10-soc fpga manager devicetree binding file from
> > freeform format to json-schema.
> >
> > Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
> > +maintainers:
> > +  - Moritz Fischer <mdf@kernel.org>
> 
> Are these maintainers actually correct? Does Moritz work on Altera stuff, or
> did you just add him cos he is a subsystem maintainer? Really what's here
> should be people that understand the hardware.
> 

Sorry I initially had added list from maintaner script,I will change to 
people who works with the hardware in the next revision.

> > +  - Wu Hao <hao.wu@intel.com>
> > +  - Xu Yilun <yilun.xu@intel.com>
> > +
> > +description: |
> 
> The | here isn't needed, nor is point out that this is a binding in the line
> below. Please describe what the hardware is here instead.
> 

Sure I will update the info in the next revision.

Best regards
Mahesh Rao

