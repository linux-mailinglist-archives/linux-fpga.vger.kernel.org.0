Return-Path: <linux-fpga+bounces-1457-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B9C568F2
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 10:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84A154F102C
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B752D23B6;
	Thu, 13 Nov 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roEEkp3B"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB8286A4;
	Thu, 13 Nov 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025024; cv=none; b=PcOfVyAKXiQ5oZdFTwt+ufwRNCaBMbCoZZ+3S09pNihloMMD0IGWINYhDUm4XYpe+ft2DNndaCQ4qy+GquPWZVtRRZEi0iArfo/iTJHRRmVktt3aL7kuwdXTvtQeeJcokKvldoCAJ71YVkIqONgHhSvtfQU4pteU/RfXdZutcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025024; c=relaxed/simple;
	bh=vH5Li4CaTekqHCRvDV+qpLf10K31NLfs1EW5kRfcBKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4z4AYEdx7vuFFusnJ2Mm9cgPbxHxIU+4hsxETk+D1I66H4NXXMIZfFkbUqQ27+HlMxTb+l9mT3LzJPZ8at7xiB9MNelJPZJrU62WJOBfb3Yy1Hz4wdqBflmj74bKVVA5Z/OeGi+mES2MRd21M5aYJypp4SYsU7h6yQy8ikHPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roEEkp3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73791C4CEF1;
	Thu, 13 Nov 2025 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763025023;
	bh=vH5Li4CaTekqHCRvDV+qpLf10K31NLfs1EW5kRfcBKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=roEEkp3BUExsrQHQ9J4uGXsJFvSzNnyFjwOOBLcHYpDxJ8pyvNKH3lfnF1KdxV83L
	 +U3cKTvQq2o5O/FBC7zGVbcLYwHkSVwheNL1n/WOfwOz26BcgqrlL1GNeL1vCFEPkx
	 GFK3gT/tEygh0JdStjv4Y0vQ4g5s40bbeiolOt5/mZoX42Kjjusct/BNgfPIMaH0Nn
	 QRRkynI++7oUz81j3K56gIYFX7XMVLsREnQnWUGjcVCewyScP9D0URL3qwfNJzHvfu
	 4MVVTavvjIwzZcejIIIQDqjo9fIi4fyrQheYo9Wuat+RgBViWoz1J1xIpa4qBrXQry
	 hB9RYVFOtKOQw==
Message-ID: <00d09e4a-2bcb-4158-803a-d298aad33a95@kernel.org>
Date: Thu, 13 Nov 2025 10:10:18 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Enable FPGA Manager support for Agilex5
To: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rao, Mahesh" <mahesh.rao@altera.com>,
 "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@altera.com>,
 "Rabara, Niravkumar Laxmidas" <nirav.rabara@altera.com>,
 "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
 <aRV0UCZD6fwnfWUE@yilunxu-OptiPlex-7050>
 <a0214340-d0dd-4689-9692-d934f3a80c40@kernel.org>
 <cdd2d579-65a3-4e1f-b8e8-45b30a6d9848@altera.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <cdd2d579-65a3-4e1f-b8e8-45b30a6d9848@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2025 10:07, Romli, Khairul Anuar wrote:
> On 13/11/2025 3:13 pm, Krzysztof Kozlowski wrote:
>> On 13/11/2025 07:01, Xu Yilun wrote:
>>> On Thu, Nov 13, 2025 at 12:43:54PM +0800, Khairul Anuar Romli wrote:
>>>> This patch series adds device tree bindings, driver support, and DTS
>>>> updates to enable FPGA Manager functionality for Intel Agilex5 SoC.
>>>>
>>>> These changes are intended to enable FPGA programming and management
>>>> capabilities on Agilex5-based platforms.
>>>>
>>>> ---
>>>> Notes:
>>>> Patch #3 depends on  "arm64: dts: intel: Add Agilex5 SVC node with memory
>>>
>>> There is no patch #3 now. Should be Patch #2 ?
>>>
>>>> region" from
>>>> https://lore.kernel.org/all/3381ef56c1ff34a0b54cf76010889b5523ead825.1762387665.git.khairul.anuar.romli@altera.com/
>>>>
>>>> This patch series is applied on socfpga maintainer's tree
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19
>>>
>>> Given that, @Dinh Nguyen could you take the series if you are good?
>>
>> This was never tested, so series cannot be taken.
>>
>> NAK, Altera should test the code BEFORE sending it to upstream, not
>> after we say it was not tested.
>>
>> Best regards,
>> Krzysztof
> 
> If you are referring to the code being tested on the Agilex5, it was
> tested. I even take the measure to add the debug print the in init to
> see if the fallback is working, which it did.
> 
> Of course I took clock manager patch from Dinh's clock manager driver
> for Agilex5 have local defconfig instead of using default defconfig for
> testing the code.
> 
> https://lore.kernel.org/all/9326ee66cb8e33c0fe83a24e9a1effc8da252ff2.1760396607.git.khairul.anuar.romli@altera.com/
> 
> Are you referring to different kind of test?

Yes, test by tools, because you certainly do not want to engage
reviewers if computers do the job fine.

see any DT talk (there where like four last years!) or
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/

Best regards,
Krzysztof

