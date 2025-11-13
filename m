Return-Path: <linux-fpga+bounces-1460-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8614C57CB3
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 14:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390E14A1FFA
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDA2212B31;
	Thu, 13 Nov 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byrY5wbf"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB91199931;
	Thu, 13 Nov 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041295; cv=none; b=lq7nLh5B8HJcPbFrELIqNxFlHIblWvaTE/QQnsIPoRiKbJ1aJFxZOJWYmKqcHrVg/zLZVHcS/tFAIuBP5PDfwrd++u2bNdOhzvaZGhKwXuu5vu/xqYGGKLvURa1C+JB7CUMH5LVsMPq6IcYaTPOUefVnAaQtAqsmAuB8ZuAaU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041295; c=relaxed/simple;
	bh=0oPmjX7i+4dV5SIthOu1LFMeA79wevcnzEIBElFpTmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLoPH3TZZRekrZ4BmCY0sSciNIxuASoGEgxe2pD3XIaz4W2aVh1Axou30+4/2KZuYivDFp7mNkutCQYEDnaPsEF3+hhpZ8zbR0+4QlT6yZppkGy1KBBrOb7ZZajAKlHlM0xtNAyurjzmcap9C3eWeN1ZrPNjT83N6TrEdFX9j6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byrY5wbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A76C16AAE;
	Thu, 13 Nov 2025 13:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763041295;
	bh=0oPmjX7i+4dV5SIthOu1LFMeA79wevcnzEIBElFpTmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=byrY5wbfZMZ+z2ZUFglfbQogR4lorOu40Lgb2ePAXgriuMiAdxdS0HYu3CoGYvqeg
	 eubvmiAD5gg60yAG5y14vAZ+jienPvSnd9/eJV4zpVH94xVjBOOW8HrUkTiJOj40jK
	 F9LQaIyXTzzak6XgAbJm5FRFf/55BBqbIj/veydPdDKJ6fVEYhwwb0zGYP7wtP3GOu
	 HFNwI+vc8NIcatnQy4Mav8fy2oHnAV/bIE3lx4I8LXzjqhM41mvRi5l2jGj7dPXUM4
	 b8iSjxUny+nV4tUE+Msvrix1G9en6qWCOj5SAuwWuT1Xsn45MvQ3MPb0HV0wsaVgKK
	 CofdSAAGe5G8w==
Message-ID: <9b9796e9-414d-4af3-bcf0-40eda370ec31@kernel.org>
Date: Thu, 13 Nov 2025 14:41:30 +0100
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
 <00d09e4a-2bcb-4158-803a-d298aad33a95@kernel.org>
 <c3ae06f0-e4d0-48ed-a589-fb6fef3fe68d@altera.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <c3ae06f0-e4d0-48ed-a589-fb6fef3fe68d@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2025 10:38, Romli, Khairul Anuar wrote:
> On 13/11/2025 5:10 pm, Krzysztof Kozlowski wrote:
>> On 13/11/2025 10:07, Romli, Khairul Anuar wrote:
>>> On 13/11/2025 3:13 pm, Krzysztof Kozlowski wrote:
>>>> On 13/11/2025 07:01, Xu Yilun wrote:
>>>>> On Thu, Nov 13, 2025 at 12:43:54PM +0800, Khairul Anuar Romli wrote:
>>>>>> This patch series adds device tree bindings, driver support, and DTS
>>>>>> updates to enable FPGA Manager functionality for Intel Agilex5 SoC.
>>>>>>
>>>>>> These changes are intended to enable FPGA programming and management
>>>>>> capabilities on Agilex5-based platforms.
>>>>>>
>>>>>> ---
>>>>>> Notes:
>>>>>> Patch #3 depends on  "arm64: dts: intel: Add Agilex5 SVC node with memory
>>>>>
>>>>> There is no patch #3 now. Should be Patch #2 ?
>>>>>
>>>>>> region" from
>>>>>> https://lore.kernel.org/all/3381ef56c1ff34a0b54cf76010889b5523ead825.1762387665.git.khairul.anuar.romli@altera.com/
>>>>>>
>>>>>> This patch series is applied on socfpga maintainer's tree
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19
>>>>>
>>>>> Given that, @Dinh Nguyen could you take the series if you are good?
>>>>
>>>> This was never tested, so series cannot be taken.
>>>>
>>>> NAK, Altera should test the code BEFORE sending it to upstream, not
>>>> after we say it was not tested.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> If you are referring to the code being tested on the Agilex5, it was
>>> tested. I even take the measure to add the debug print the in init to
>>> see if the fallback is working, which it did.
>>>
>>> Of course I took clock manager patch from Dinh's clock manager driver
>>> for Agilex5 have local defconfig instead of using default defconfig for
>>> testing the code.
>>>
>>> https://lore.kernel.org/all/9326ee66cb8e33c0fe83a24e9a1effc8da252ff2.1760396607.git.khairul.anuar.romli@altera.com/
>>>
>>> Are you referring to different kind of test?
>>
>> Yes, test by tools, because you certainly do not want to engage
>> reviewers if computers do the job fine.
>>
>> see any DT talk (there where like four last years!) or
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>
>> Best regards,
>> Krzysztof
> 
> Thanks, I can see the error with make -j48 CHECK_DTBS=y
> DT_SCHEMA_FILES=intel,stratix10-soc-fpga-mgr.yaml
> intel/socfpga_agilex5_socdk.dtb;
> 
> If i revert back without adding "intel,agilex-soc-fpga-mgr"", the tool
> is able to pass without any issue. But we need the driver entry to make
> it able to load as it compare the entry from dts and the compatible
> entry in the driver.
> 
> Should we add back the entry in the driver like in the v1? Or, shall we
> defer the driver changes for now?

You ask now about basics of DT, so sorry but doing homework is your
task. Maybe the beginners DTS talk from this year's OSSEU will be
helpful here. Or one of many other resources...

Best regards,
Krzysztof

