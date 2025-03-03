Return-Path: <linux-fpga+bounces-1089-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28AEA4BC61
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 11:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A5B16AAA7
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD9C1F0E33;
	Mon,  3 Mar 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq0kz0b+"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7C1EB5D7;
	Mon,  3 Mar 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998084; cv=none; b=ES3zxDJfR7T+NHltyd4wPyuG7T7O23y2Ta5K2BERC5BCvy42q5s3R9d2OSuP6t+J7rf3q+DRE/b+Rgjd046cPlRNC25I6RLOysQ/SNFGQMBBzOu/BRd0zmI/LjVDiwWlNeZeac9LnsbL/+10mNHEx3cQdHwOrqFn5CSa3Ju1D/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998084; c=relaxed/simple;
	bh=tXdZtA8dPY2SJ03JLnHXPguoj5lZoDS1yGRwQr6eFGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRZ1LKf1dDxWPKFn3YOAOjVOlyiL84fnVb8ewltJNI9SvmKuTCymuBeqbT03Qday3oIpggem6cpQ+rssWaXx6Dvw7D6MmB/Yf92E5y0g2R/Y9/+gK6ur4/Wf05m+K1CELxRASccvAakzEn4KU4wzSJAZltUmQHDB1YszTeAQtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq0kz0b+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE615C4CED6;
	Mon,  3 Mar 2025 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998083;
	bh=tXdZtA8dPY2SJ03JLnHXPguoj5lZoDS1yGRwQr6eFGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oq0kz0b+8Z6X0wwQXJJJB72Z+MjVWF3RVvZeRGKdXS2ybvrpR3gW6bCFUYVr+oMKe
	 W33h9t8eUPhaNrFSANGX73lfWETmb1dyGTTl/Tlllo0+ZBX+yKvUVM3nEKfMDoad50
	 ZJWCMWEe5r+X56MTSykBZLWNmx3zKXrGXs9pWnSZ+zVNIqqgUQRXaEVs9DaNMMezue
	 S8iFUcarIabiyK18eKCFS+Fc0bNnBmPRfdO6mO0DS9fBOxWG/Rp3tD4OkCadK/u/wU
	 QBioxKpTyOWHVRuGG9fxWos66JNGKuWnA4uM5m6G8+JUrPskGs/vG1Zn+0L5mfFkmI
	 /ihdW5vllKqIg==
Message-ID: <766cc092-896f-4dc7-b1e4-9996b4b8f35d@kernel.org>
Date: Mon, 3 Mar 2025 11:34:35 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
To: Conor Dooley <conor.dooley@microchip.com>,
 Ian Dannapel <iansdannapel@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, linux-fpga@vger.kernel.org,
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Aradhya Bhatia <a-bhatia1@ti.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-3-iansdannapel@gmail.com>
 <20250228-copilot-trekker-72a20709e9f7@spud>
 <CAKrir7hdyP-bPKkZOpK3cFp=rvH_MJ98DLKnsRni_BWsQEg5yw@mail.gmail.com>
 <20250303-imply-ferocity-bbb6d866b149@wendy>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250303-imply-ferocity-bbb6d866b149@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/03/2025 11:31, Conor Dooley wrote:
> On Mon, Mar 03, 2025 at 11:10:53AM +0100, Ian Dannapel wrote:
>> Hi Conor, thanks for the quick response.
>>
>> On Fri, Feb 28, 2025 at 7:28 PM Conor Dooley <conor@kernel.org> wrote:
>>>> +description: |
>>>> +  Efinix FPGAs (Trion, Topaz, and Titanium families) support loading bitstreams
>>>> +  through "SPI Passive Mode".
>>>> +  Note 1: Only bus width 1x is supported.
>>>> +  Note 2: Additional pins hogs for bus width configuration must be set
>>>> +  elsewhere, if necessary.
>>>> +  Note 3: Topaz and Titanium support is based on documentation but remains
>>>> +  untested.
>>>
>>> Points 1 and 3 here seem to be driver limitations, and shouldn't really
>>> be present in a document describing the hardware?
>>>
>> Yes, they are driver limitations and probably do not belong here.
>>
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - efinix,trion-spi
>>>> +      - efinix,titanium-spi
>>>> +      - efinix,topaz-spi
>>>
>>>> +      - efinix,fpga-spi
>>>
>>> What hardware does this device represent? Other ones are obvious matches
>>> to the families you mention, but what is this one?
> 
>> The proposed compatible is a generic fallback for any Efinix FPGA Series.
> 
> If it is a fallback, your binding should look like:
> compatible:
>   items:
>     - enum:
>         - efinix,trion-spi
>         - efinix,titanium-spi
>         - efinix,topaz-spi
>     - const: efinix,fpga-spi
> 
> |+static const struct of_device_id efinix_spi_of_match[] = {
> |+       { .compatible = "efinix,trion-spi", },
> |+       { .compatible = "efinix,titanium-spi", },
> |+       { .compatible = "efinix,topaz-spi", },
> 
> And these three compatibles can/should be removed from the driver, since
> the fallback is required.
> 
> |+       { .compatible = "efinix,fpga-spi", },
> |+       {}

Yes, except that one of the devices should be the fallback, not generic
"fpga".


Best regards,
Krzysztof

