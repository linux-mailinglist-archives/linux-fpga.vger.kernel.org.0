Return-Path: <linux-fpga+bounces-1063-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE8BA3CF53
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Feb 2025 03:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6B1896D18
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Feb 2025 02:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6B71CAA9A;
	Thu, 20 Feb 2025 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEREULTT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941991C5D79;
	Thu, 20 Feb 2025 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018373; cv=none; b=JT05xvL01oFcoMu5Fg8HC8U3NO74DIL5mg+myB76vtWlEcQh0fv6B6Pvx0HIc6t0GpWemV0uKzk4mVdbkJSO+3oE2f0DhzlD4c8+ApB166p7ip7YDhWmKLzI5olm1OnXxqHaOjW3H11P3VUQL3MNMiB12qeyMM1mqKqtHr58JbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018373; c=relaxed/simple;
	bh=s3bTR+sYzYnDwPwEZR56Fskr/iBsH64l55XfLz4joSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQQ6kzshQNBsjd0Re3bdag+hdGNKys5EmjgLxaAfEAN9a+qdd2qmk8mKylmnp3AD+oujBac+XVRPsm7WsCrrlwTNFsy+qS9xhxJO67FQdzpiYo60f550+xQloOegVdk7dZ0AqVWVivnmvPO/h3THab4E5aXZoB20r5bOoQVvv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEREULTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08812C4CED1;
	Thu, 20 Feb 2025 02:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740018373;
	bh=s3bTR+sYzYnDwPwEZR56Fskr/iBsH64l55XfLz4joSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DEREULTTr2ml/h7lFeR62J13qYU1ZJLCykQr8u+esAHKzh0l4c66e82KeQln3tqxp
	 ThNBmKRsqp36/TBTdfa+cZZ42GzvVLam2hqxryQZWZqcpsqe4XArykiSCL1FgkkB6I
	 MTG8gE4zlMnr9xzjaBecCPZMKYi9Ycfx/aIZ1MfTMWMdJrx4rD22z02XGJehgAY3mJ
	 bcU12ZphApM2tOhrvWQ3u8nP02I8w1I6KpkuXGa8+J/zdmywWdDm7+jlY3jYpu6LWq
	 vvDRUcIFX5KQ2hYKLX+mDCqUcF2/V2t46YQ5Xb//anjrTJxZQqR+ChysneNm3Fzwrh
	 /sh8DgGHnUCyQ==
Message-ID: <25a9720d-0600-408e-a68e-0caab3d04114@kernel.org>
Date: Wed, 19 Feb 2025 20:26:10 -0600
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] stratix10: miscellaneous changes and fix for child
 driver probing
To: Mahesh Rao <mahesh.rao@intel.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Wu Hao <hao.wu@intel.com>, Ho Yin <adrian.ho.yin.ng@altera.com>,
 Niravkumar L Rabara <nirav.rabara@altera.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>
References: <20250204-socfpga_sip_svc_misc-v3-0-697f7f153cfa@intel.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250204-socfpga_sip_svc_misc-v3-0-697f7f153cfa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/4/25 06:58, Mahesh Rao wrote:
> The patch set includes the following changes:
> 
> - Conversion of the devicetree binding file to JSON-schema for the Stratix10
>    SVC driver and its child stratix10 fpga manager driver.
> - Addition of support for probing the child driver. This fixes the failure
>    of child driver probing as the SVC driver node has been moved out of the
>    SoC node.
> 
> Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
> ---
> Changes in v3:
>    * Updated reserved-memory node as per dt-schema.
>    * Adjusted the indentation and corrected usage for
>      multi-paragraph description in stratix10-svc
>      binding file.
> 
> - Link to v2: https://lore.kernel.org/r/20250131-socfpga_sip_svc_misc-v2-0-eeed4ebc35f9@intel.com
> 
>

All patches applied!


