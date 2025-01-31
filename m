Return-Path: <linux-fpga+bounces-1029-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5570DA23F8F
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 16:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D819C1882EE7
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD351DEFDD;
	Fri, 31 Jan 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3dzLlh1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BDD1C1F29;
	Fri, 31 Jan 2025 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738336973; cv=none; b=UeQmQ7UmqwengBWUy+eb7binWInp+llH2ykRPZJOjJHrYuflso/XoRkj5IRHabE6esfUEa36RtUC3Lb+7ANPtciWFZwRbih2pH64IQC7bIWn2Il7RMsTWyP1g3t7P0JjmZP/kK906rwFw8PYqMGTG0ccTS7+qn8ryOGZiqAqD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738336973; c=relaxed/simple;
	bh=2XSUwqfKsVEp3IMiM6NQTuflLjZEWzIWnFosGHmPs2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPejAEB9sPajkNdSupViI2RupZUAK/RNg/SVOSGqkhFU/uNkALO7q7CzNVVIhBxK/WzWIWTeW7/4xK2smi38aQjavYoOinjSFxsBY80Gzi4h+jovNWGKZDbvRjfFlKWDeKBaiPcp3nRgjD3AGiXu3CvI63qRCroPpSWCeXoWNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3dzLlh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83966C4CED1;
	Fri, 31 Jan 2025 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738336972;
	bh=2XSUwqfKsVEp3IMiM6NQTuflLjZEWzIWnFosGHmPs2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3dzLlh1NaPsV31KDezvmTY4PNSIBxDRjKMUrfttkMI0R3aEHvxwQKqmvfvVFgNXX
	 U+W2wQwOmKYGKiALGcw2rYbPdxJiC64fsOeFzyY8Uk1DrEGeKY4QV9UZFRq7fBAMZB
	 fWXZXc2e3KPnV+eQ7llS/yPiVUOpNou6xeglaazE1Gi1Npk5tq8WTolg4AyvRL9dcD
	 QWubyfwgdxvxQw9HAqIGZyhnAba/xB59FVaDqrOMHJZ9L2I1jO/PNdOGobRxSsx5JW
	 TaNTLZoEroKWuTIecapgOqGszrhIGugpqBExJl9bTADiYg/vK6wTcMtnX74h0QwGXm
	 bG0wl7XMULpKw==
Date: Fri, 31 Jan 2025 09:22:51 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mahesh Rao <mahesh.rao@intel.com>
Cc: linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>,
	devicetree@vger.kernel.org,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>, Wu Hao <hao.wu@intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Moritz Fischer <mdf@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-fpga@vger.kernel.org, Ho Yin <adrian.ho.yin.ng@altera.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: fpga: stratix10: Convert to
 json-schema
Message-ID: <173833697109.3454158.16328631398672207648.robh@kernel.org>
References: <20250131-socfpga_sip_svc_misc-v2-0-eeed4ebc35f9@intel.com>
 <20250131-socfpga_sip_svc_misc-v2-1-eeed4ebc35f9@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-socfpga_sip_svc_misc-v2-1-eeed4ebc35f9@intel.com>


On Fri, 31 Jan 2025 18:17:24 +0800, Mahesh Rao wrote:
> Convert intel,stratix10-soc fpga manager devicetree
> binding file from freeform format to json-schema.
> 
> Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
> ---
>  .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 36 ++++++++++++++++++++++
>  .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt | 18 -----------
>  2 files changed, 36 insertions(+), 18 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


