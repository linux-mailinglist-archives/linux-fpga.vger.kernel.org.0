Return-Path: <linux-fpga+bounces-1443-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98368C4C9DD
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07F9188615F
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CCD2ECEBC;
	Tue, 11 Nov 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dU2GmLLN"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161127CB35;
	Tue, 11 Nov 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852707; cv=none; b=soExPlsp/V3diKgv8vbHtMhZvD9Y7NnTCwyv8o6i5+z3zQvn3SUh5pGFQJxkpTDAWOkavDrHT++OErKn9gJkNdOXKx2T9IZprXsQHCuFcxuXy8VgyCAjD3FKM2FQ99XdboUiyGFkXONaEaOhyM+dGtBqwaF1dc61Rgwh/iqpyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852707; c=relaxed/simple;
	bh=DtC6/Dh6DnzzueO+csTSLKdwgV4e4PHq9ax7gNVMgMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVE/kesG0KH5iwScF9GSrQDCtzmFBMtToOkBHEmEaExIKE/E9nE2hq82OrJNXwRE61z7hjm0HhN+fMJUWB6Il6SYR/pQLEo0KV4+aVuPu7rpVvfKj+WEDMIJQ0Wa1YCsvW/i4hfM9yTKcMNp5K3cNS8N6aV3a9KogW7BF7DPRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dU2GmLLN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762852706; x=1794388706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DtC6/Dh6DnzzueO+csTSLKdwgV4e4PHq9ax7gNVMgMo=;
  b=dU2GmLLNfXi7yjoQNNiYWhwWdzmey+VW8c4L4JU5mRuCiIqoBzRLpNf6
   XMNYmL1bzsYHryIZek/+OgcDQq9z0dshmfbaKMKNleLGKL/LzOMWWz2ZF
   jpAdn19DULCqV9Ep0QtccsOigeGI99v5EF32fDCEitg8BCccZXgyG9lGF
   cWMUd4QLxj0p9WpLZQG2j3IZmUTxoQB7WndL6ePHFKi/2UxY6ODvNfbp2
   m1K8Twz4JmCysOOVTTk76ELOWNwRtx535U5wTSUvGmpuQHPqvpqiRoSWd
   kokCWGLuzum0L4fo+wyA/G4X1RNHIyTPw5mkCwIa24tPlhImQkQM5MVeG
   A==;
X-CSE-ConnectionGUID: eSB7xDJtTOq7L28cnoTi9Q==
X-CSE-MsgGUID: uzsIgaFVTqCj0YfIhkvfeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64796652"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64796652"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 01:18:25 -0800
X-CSE-ConnectionGUID: ZUqQRFoQQPy3vk3VG2Z+HQ==
X-CSE-MsgGUID: qmajfKkcR8CZG0b3UbX9Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189171362"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 11 Nov 2025 01:18:21 -0800
Date: Tue, 11 Nov 2025 17:03:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: fpga: stratix10: add support for Agilex5
Message-ID: <aRL7/Hjb1Z/OrC91@yilunxu-OptiPlex-7050>
References: <cover.1762835252.git.khairul.anuar.romli@altera.com>
 <0e3986dd9a2c4e46466a7430b2573d170d2a718a.1762835252.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e3986dd9a2c4e46466a7430b2573d170d2a718a.1762835252.git.khairul.anuar.romli@altera.com>

On Tue, Nov 11, 2025 at 03:48:31PM +0800, Khairul Anuar Romli wrote:
> The Agilex 5 SoC FPGA manager introduces updated hardware features and
> register maps that require explicit binding support to enable correct
> initialization and control through the FPGA manager subsystem.
> 
> It allows FPGA manager drivers detect and configure Agilex 5 FPGA managers
> properly. This changes also keep device tree bindings up to date with
> hardware platforms changes.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
>  .../devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
> index 6e536d6b28a9..b531522cca07 100644
> --- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
> +++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
> @@ -23,6 +23,7 @@ properties:
>      enum:
>        - intel,stratix10-soc-fpga-mgr
>        - intel,agilex-soc-fpga-mgr
> +      - intel,agilex5-soc-fpga-mgr

I'm not quite familar about dt rules, but since these are all software
defined strings, do we really have to write down every version even if
they behave exactly the same? Seems a waste of time.

Thanks,
Yilun

>  
>  required:
>    - compatible
> -- 
> 2.43.7
> 
> 

