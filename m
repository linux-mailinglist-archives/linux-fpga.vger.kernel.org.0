Return-Path: <linux-fpga+bounces-64-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39851818DC6
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37751F278B3
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D834567;
	Tue, 19 Dec 2023 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp7JmJXf"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C331A72
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703006247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAt7JiXzmNfxd2b5RJ1nXcgqmfXVLO96NAc/uLDObCg=;
	b=Zp7JmJXfPPWSyTWf39ZJlzRyWDh/S+2O5/1ab5uH/1pCrgzuufjlmnHdEJR1NjjOKP1Gq0
	Z2/a85VWroHqm38783c3+zvAAWEed6aiJq3u2TcneQKBvRKQ8GjMKC2ujPmOEod2xZRkyH
	e6ovGZUj2s0dbpHb3cPizZhFWLz1JEA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ojHcgm3fPxuCu7vzwuUCWg-1; Tue, 19 Dec 2023 12:17:24 -0500
X-MC-Unique: ojHcgm3fPxuCu7vzwuUCWg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42781bfcba2so3881961cf.0
        for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 09:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703006243; x=1703611043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAt7JiXzmNfxd2b5RJ1nXcgqmfXVLO96NAc/uLDObCg=;
        b=p/KcQH0DBfXuvXkqrdSZntlJiP52phsP/BWGr58TnglzcNAYeCtRyNJ5Mq/aEEDASt
         ijTTz6lSISvqUyIHbl/bJvGamas6j6Q/e9PcQbutwou7VlktIu2Agjq92Vr0xJjhDSV+
         0vro+qgloEagQaWBBCzYUFbE4/KwVEEqdMoTk6rcTOt5c3UpMT97QJ1ix6bO2ChMkhxQ
         pGCHJnmj4du+vmYNeZfbIB4Vz7SfnVRZLkY/kJ/bIdi5jTdH+GH+qDuMhGgc2N0CmOmP
         xFQ1Hw8jAn14FPVcsXwb4AAAL7Ei6v6QEWGyY75yuiioaVdMCq6rKyCozFx3FF8URuQJ
         H8Gg==
X-Gm-Message-State: AOJu0YwmtnGlouBFK55TshEAEaOtk1NAIdvmmmoHGZrl7b208tTlPvAV
	eji+G5JL81a06IrAjqrv/4K0rO99hx3z3lZ/MFCjxWeKABet/FVMA0KpnZfGshpUB19e62Ti45T
	rAZRJws5g1UAFNAMQPMs4
X-Received: by 2002:ac8:5ad1:0:b0:423:7a01:3a65 with SMTP id d17-20020ac85ad1000000b004237a013a65mr24793076qtd.35.1703006243651;
        Tue, 19 Dec 2023 09:17:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2jjva7fgBRdAJJJu+d1gf0zXdcO+LTHjJgogTJ6jzZZxlP11DghTwYQbZc4in6iLQonpjOA==
X-Received: by 2002:ac8:5ad1:0:b0:423:7a01:3a65 with SMTP id d17-20020ac85ad1000000b004237a013a65mr24793063qtd.35.1703006243352;
        Tue, 19 Dec 2023 09:17:23 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id o25-20020ac872d9000000b004258264d166sm10307046qtp.60.2023.12.19.09.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 09:17:23 -0800 (PST)
Message-ID: <b2d3d88e-840d-48b1-86d4-0a89d6143683@redhat.com>
Date: Tue, 19 Dec 2023 18:17:20 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] fpga: set owner of fpga_manager_ops for
 existing low-level modules
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-3-marpagan@redhat.com>
 <2023121829-zealous-prissy-99cc@gregkh>
 <9296941c-a3c8-4d55-9e52-f1277f1c3fc7@redhat.com>
 <2023121924-extent-defender-fb06@gregkh>
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <2023121924-extent-defender-fb06@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2023-12-19 16:10, Greg Kroah-Hartman wrote:
> On Tue, Dec 19, 2023 at 03:54:25PM +0100, Marco Pagani wrote:
>>
>>
>> On 2023-12-18 21:33, Greg Kroah-Hartman wrote:
>>> On Mon, Dec 18, 2023 at 09:28:09PM +0100, Marco Pagani wrote:
>>>> This patch tentatively set the owner field of fpga_manager_ops to
>>>> THIS_MODULE for existing fpga manager low-level control modules.
>>>>
>>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>>> ---
>>>>  drivers/fpga/altera-cvp.c             | 1 +
>>>>  drivers/fpga/altera-pr-ip-core.c      | 1 +
>>>>  drivers/fpga/altera-ps-spi.c          | 1 +
>>>>  drivers/fpga/dfl-fme-mgr.c            | 1 +
>>>>  drivers/fpga/ice40-spi.c              | 1 +
>>>>  drivers/fpga/lattice-sysconfig.c      | 1 +
>>>>  drivers/fpga/machxo2-spi.c            | 1 +
>>>>  drivers/fpga/microchip-spi.c          | 1 +
>>>>  drivers/fpga/socfpga-a10.c            | 1 +
>>>>  drivers/fpga/socfpga.c                | 1 +
>>>>  drivers/fpga/stratix10-soc.c          | 1 +
>>>>  drivers/fpga/tests/fpga-mgr-test.c    | 1 +
>>>>  drivers/fpga/tests/fpga-region-test.c | 1 +
>>>>  drivers/fpga/ts73xx-fpga.c            | 1 +
>>>>  drivers/fpga/versal-fpga.c            | 1 +
>>>>  drivers/fpga/xilinx-spi.c             | 1 +
>>>>  drivers/fpga/zynq-fpga.c              | 1 +
>>>>  drivers/fpga/zynqmp-fpga.c            | 1 +
>>>>  18 files changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>>>> index 4ffb9da537d8..aeb913547dd8 100644
>>>> --- a/drivers/fpga/altera-cvp.c
>>>> +++ b/drivers/fpga/altera-cvp.c
>>>> @@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
>>>>  	.write_init	= altera_cvp_write_init,
>>>>  	.write		= altera_cvp_write,
>>>>  	.write_complete	= altera_cvp_write_complete,
>>>> +	.owner		= THIS_MODULE,
>>>
>>> Note, this is not how to do this, force the compiler to set this for you
>>> automatically, otherwise everyone will always forget to do it.  Look at
>>> how functions like usb_register_driver() works.
>>>
>>> Also, are you _sure_ that you need a module owner in this structure?  I
>>> still don't know why...
>>>
>>
>> Do you mean moving the module owner field to the manager context and setting
>> it during registration with a helper macro?
> 
> I mean set it during registration with a helper macro.
> 
>> Something like:
>>
>> struct fpga_manager {
>> 	...
>> 	struct module *owner;
>> };
>>
>> #define fpga_mgr_register(parent, ...) \
>> 	__fpga_mgr_register(parent,..., THIS_MODULE)
>>
>> struct fpga_manager *
>> __fpga_mgr_register(struct device *parent, ..., struct module *owner)
>> {
>> 	...
>> 	mgr->owner = owner;
>> }
> 
> Yes.
> 
> But again, is a module owner even needed?  I don't think you all have
> proven that yet...

Programming an FPGA involves a potentially lengthy sequence of interactions
with the reconfiguration engine. The manager conceptually organizes these
interactions as a sequence of ops. Low-level modules implement these ops/steps
for a specific device. If we don't protect the low-level module, someone might
unload it right when we are in the middle of a low-level op programming the
FPGA. As far as I know, the kernel would crash in that case.

Thanks,
Marco


