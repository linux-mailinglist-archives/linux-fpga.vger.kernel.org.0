Return-Path: <linux-fpga+bounces-1044-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F61A2A269
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 08:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8246D3A32B1
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2093224882;
	Thu,  6 Feb 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K66GIEWM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD38200B9F;
	Thu,  6 Feb 2025 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827543; cv=none; b=e+L6Jjew69qGgYchH6aMbUCRGn9DJKjNTNRqs4nZR5cX5BcUI1sv1GBLkv414LbU9fq0ly1E+M8O5JKF6v3lpwuQmI+iYnreFxmUQgrWuTrcJZ235WWJz1siagfp4oxX46lp+4pqP24L9WrEVZL2zdVhVkFp4u4LZy8qqUS85Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827543; c=relaxed/simple;
	bh=MnmdLQx2ow682oD9+N9jYiapyYBpeN/iraHJhdE90E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKDwzMPWED0qEhHOkhPv3+3yLSoEgSNK3wY4u+4FlDOgg2gF2eMenjXTxfnGs/8ziX2GMb7cNBnqmK511sk7ddYlU5g+zYKEgL9f+sOIHcb5s0rP57pPUtFOwNhDyYiKbiYDOE5MkOSAfvNoBqNt0wJhsX0HBUv4mFkqfyPc8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K66GIEWM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738827541; x=1770363541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MnmdLQx2ow682oD9+N9jYiapyYBpeN/iraHJhdE90E0=;
  b=K66GIEWM+eVMd6+BXfJhnkUf6VXKdVkxUgwHEt4e6BX/3g7NkugZLjnk
   NNpa6Q7bGoLwQzufwebl/engN+pWGY0hqP/LUcKOCq24ubtx3g/k9eYhB
   HGJur9Q1unwXUS4WkfNqrcT104AV5K7fq7+pRvbpPubxMVJzHExTV+i6Y
   VogAxJXo6f8y/pPDhYJvTCafrjE49oAzgYonLyfjULb2BbezWRxkxLlr3
   hzJzbNrocihmZ7z8n/QQsp6w5q4goDqBPfmvakpiIYDcu1BF/IvMNlebt
   pc0iOM+51vVgkTTk4PjhVTJfyVZlbzojGomNwI17w71CxA07YeXQQeFzy
   g==;
X-CSE-ConnectionGUID: 69LZdrY+QcawPbp3FVMZrA==
X-CSE-MsgGUID: /1h6NWh/TICb3hZJAtpueA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61892063"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="61892063"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 23:38:11 -0800
X-CSE-ConnectionGUID: 3CLQHxKVRJeM2YYSCs39Tw==
X-CSE-MsgGUID: KcVbNmp5TRuIv5HBADv2Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115739722"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 05 Feb 2025 23:38:09 -0800
Date: Thu, 6 Feb 2025 15:37:17 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@altera.com>
Cc: Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	Peter Colberg <peter.colberg@intel.com>
Subject: Re: [PATCH] fpga: m10bmc-sec: update email address for Peter Colberg
Message-ID: <Z6RmrcW7vvX1geBt@yilunxu-OptiPlex-7050>
References: <20250127201634.17097-1-peter.colberg@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127201634.17097-1-peter.colberg@altera.com>

On Mon, Jan 27, 2025 at 03:16:34PM -0500, Peter Colberg wrote:
> Update my email address after Altera became a subsidiary of Intel on
> January 1, 2025.
> 
> Signed-off-by: Peter Colberg <peter.colberg@altera.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next

