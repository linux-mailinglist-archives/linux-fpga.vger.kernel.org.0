Return-Path: <linux-fpga+bounces-1019-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B02A1DAFF
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Jan 2025 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9CFB3A30AA
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Jan 2025 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5F18859A;
	Mon, 27 Jan 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ablNZYVg"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6E1885B3;
	Mon, 27 Jan 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997638; cv=none; b=gJ52Sc5kA/6taSOA8RDKZo++KIELa8PjeO7RAfoxfMGa0ogh7I0Q8Zi1tvGVakckTzr0O4457DtwtxfPjljbeFfLN28qGALEh4m0SByBRp9guiOrOZ3RSh+sYR3qgsLhyCD7kA3tXpvIbatmZ5ObEN8e4c2xjWHfcK+LOlhJfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997638; c=relaxed/simple;
	bh=pUUB8KCG//LM2unGcwdG84Ht4M5/P2N62irppFkJmKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruBOiJclIuPiKGriO364/8DM5XeiKeCUxB0S2Yu5wt95oQbaKJaLU7eo4j32+q6IuTyAivdpqfzqPcImfFeWKfQ0NZfwxPqbmsSSIMIgshOHYnTMp1tJmG8vNVg5RJM0BhXXvuAeXJ08ZxDKdtFisllzQP6UzxmXCTDJYtkmhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ablNZYVg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737997636; x=1769533636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pUUB8KCG//LM2unGcwdG84Ht4M5/P2N62irppFkJmKw=;
  b=ablNZYVggf89mP/sUC8WJPP0/WKkEOGKcrjh8+TVlj/TfKPhj7VbJ1fC
   5Q/V7jPbvUy9dX3uHwlMsQ2yLu4v8WtYcdtiOAgPrdltUPa+aoxE94nuj
   ekgljmECGmToYlwirXGeFsJ1qACjMx0GI0ieDTX8atvprIq5eE7/9k1Cu
   yti+q+MWfD7bXoN3uGOHxw/BWfdJAJcf8YHOAOs1CNk0cVo+VywEVRccV
   irN7ZUfD1YwOfnyNoWK261MUKzVpAVU84oNw/a1MgJCAN5t7cMsvyJHXk
   fOoiiHD7YO6NECW5kp0QLXFDu67q9Q11T69AZ+NbBzMl4GR4jbne7mi0j
   Q==;
X-CSE-ConnectionGUID: J6zClvOUSAqrAQoanoIR4g==
X-CSE-MsgGUID: 48MkT0FESiqEP/X5KOZozg==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="42132364"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="42132364"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 09:07:15 -0800
X-CSE-ConnectionGUID: IQ5gXYMaTT2Mt9HIK+ONuw==
X-CSE-MsgGUID: MldP2UXrRcCTnDkgiRpHHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="108464717"
Received: from apgc00009.png.altera.com ([10.244.70.6])
  by orviesa006.jf.intel.com with ESMTP; 27 Jan 2025 09:07:12 -0800
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
Subject: Re: [PATCH 2/3] dt-bindings: firmware: stratix10: Convert to json-schema
Date: Tue, 28 Jan 2025 01:07:05 +0800
Message-Id: <20250127170705.12988-1-mahesh.rao@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250122-decode-celtic-fb7a491957bb@spud>
References: <20250122-decode-celtic-fb7a491957bb@spud>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Conor Dooley,

On Wed, 22 Jan 2025 18:40:41 +0000, Conor Dooley wrote:
> > Convert intel,stratix10-svc service layer devicetree binding file from
> > freeform format to json-schema.
> 

> > +
> > +  method:
> > +    enum: [smc, hvc]
> > +    description: supervisory call method to be used for the service layer.
> 
> This looks to be missing a type (string) and an explanation of what "smc" and
> "hvc" are.
> 

Thanks for pointing out , will do the change in next revision.

> > +
> > +  fpga-mgr:
> > +    $ref: /schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml
> > +    description: Optional child node for fpga manager to perform fabric
> configuration.
> 
> This is new and not justified in your commit message. Please explain where
> this has come from in v2.
> 
> Cheers,
> Conor.
> 

Sure, this is an optional child node/driver present in the device tree for
the Agilex SoC devices, but it was not mentioned in the text documentation.
Therefore, I had included it here. I will provide more details about this
change in the next version.

Best Regards
Mahesh Rao

