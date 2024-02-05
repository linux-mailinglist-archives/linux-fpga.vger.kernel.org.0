Return-Path: <linux-fpga+bounces-225-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C688D84A141
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Feb 2024 18:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F181F212FF
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Feb 2024 17:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2B47F41;
	Mon,  5 Feb 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcfFLe4a"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079247F47
	for <linux-fpga@vger.kernel.org>; Mon,  5 Feb 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155262; cv=none; b=r3CB5WStQ1cHE7ctBZminfpuxBOxxED6M7o8iOQBWvcC/uX2CUY7Xxz2TbG6xWdIe3pLNM/Rna+M81ZajFQoMg4c2fvm1fAG1zJjnJLNlqKJqcXZomITqtqC4z3QenpuR1tvAe3IymqR1En3a1ECFqBuc5tJBGcK5vPQp9Ja9fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155262; c=relaxed/simple;
	bh=YRr9xmrG/Qu7lzbwxy8pFwenZuuqtN5IUwKv14LlfiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDS07OulVKfG2YwyahAlqXs5NspzynDfXx4s1sZAHo9CjDtYHAGbSW1VxvLTPVEPZcA4lHPWktYCFzYlreyNsRt7TQKT6ABb5wVmqOp9C0HVlGX/0Ym1qcVA19KQcAyiITd2lIvh5Ef1qVqZdL/pmdJwK5fZNtdZuopsVv2iTcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcfFLe4a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707155260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brbw2jGOAYpq03eoPzMnBwz2rIsnyFqQ7SU3UeWuQGc=;
	b=FcfFLe4aZNaNUaQUa4h/i57waFyzmctaLLUuTUYudy6wMyQnhEZPynct/qpx13B4Y7thA4
	avDnK/DBaAZcYNwGEks1MH1aZTX8gbJMO2oPCCbehDh+YtJcED+qwSbPp5Sn9GboPe729d
	OJ0/LlSHAb0AeKKRDxii6YFONEJq7h0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-qv69MCD9N_6w4tmd8dWsPA-1; Mon, 05 Feb 2024 12:47:38 -0500
X-MC-Unique: qv69MCD9N_6w4tmd8dWsPA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68086d6c953so80224596d6.2
        for <linux-fpga@vger.kernel.org>; Mon, 05 Feb 2024 09:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155258; x=1707760058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brbw2jGOAYpq03eoPzMnBwz2rIsnyFqQ7SU3UeWuQGc=;
        b=SuXn/hfwQjCYBpehmkKW2A9Z7EK8yHCh5PtSzIlPc9TPf9p/OEOOFyoyOOETGhQaRO
         12HsdX+R7y226N7hEQdfMYy7iyJFIWWWAzUZD4ZofQQ1vsnyG8h/94OXdZAzm/Uh8KO5
         uQyXO4YtyFt7Ay3tiTy80c+8AfD17rs4K4iT47hurg+vg436gLgniByK0FIXzOspS9ki
         C/ppyldG1TWXKlRqIsSb921YxUBfC6NkpaoRaxZq9r8nxH5wWxGIU+1TWHOvzZXMBjdi
         +qrmYivWNgB88un5X9T2yDR1SSLoOzQfFcg7ki89OvYlQWka6hnuX3snTEAy8Tyyu30o
         TcKQ==
X-Gm-Message-State: AOJu0YwZKtgoLQRimdrPsLI46FoUBM9GCBV9U1N8EyfNEimK/+2Jypcw
	xx30XPHZCb4F6H9Io13u64ai+q2TSdzQMuMv2QtsTlwW4sXEVe3SeTzZozLZD6gEHOyCscLqtof
	EWtufmhJVExFykuslhomzbnxuBlPMfzC6p3BEadh0Uc4DC8IXTLnVB/MF8Q==
X-Received: by 2002:a05:6214:29e4:b0:68c:3f60:f09a with SMTP id jv4-20020a05621429e400b0068c3f60f09amr72455qvb.47.1707155258037;
        Mon, 05 Feb 2024 09:47:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmf1krkk1UHjWg8vTRkpvKFSEejP5Vj6buHEmjj3zrC17At+WE0pDOH8XHR02kcVwsCGZiHQ==
X-Received: by 2002:a05:6214:29e4:b0:68c:3f60:f09a with SMTP id jv4-20020a05621429e400b0068c3f60f09amr72434qvb.47.1707155257710;
        Mon, 05 Feb 2024 09:47:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWkIoJ5qhW9XD5w+SJcAQkDhXheEHBHkU0/N3GUJGctO4sj9hMBEsMPEZ8/gQJMdbGzImerb6XpuGuMc0NwEuLOReSKbRvUYaL1ZQqxovBPyE97rb7pOyxHoArlI1bHnf9s7tekPkyLAl0qposTKLQ+PgH4YWShusKRZVKnbaZclgTdWqxAQtWkilHYdDYZ5xV58ituZRLVqSLzx3mjqVPO3Ei/JBvTl5keLafivnGQbp444RTxIgQfzlOjDtNO0oKjkbp2PGVabkuaUQJwso2ogffgdeN5ublgxHG63XEKwEHBWhHq4+/CX/2Of3Efjrhq/Jt+7MriqnsA+iee8ZppVnNf
Received: from [192.168.9.34] (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id nd23-20020a056214421700b0068ca9ea78cbsm188027qvb.21.2024.02.05.09.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 09:47:37 -0800 (PST)
Message-ID: <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
Date: Mon, 5 Feb 2024 18:47:34 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Tull <atull@opensource.altera.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20240111160242.149265-1-marpagan@redhat.com>
 <20240111160242.149265-2-marpagan@redhat.com>
 <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-04 06:15, Xu Yilun wrote:
> On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
>>
>>
>> On 2024-01-30 05:31, Xu Yilun wrote:
>>>> +#define fpga_mgr_register_full(parent, info) \
>>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>  struct fpga_manager *
>>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>> +			 struct module *owner);
>>>>  
>>>> +#define fpga_mgr_register(parent, name, mops, priv) \
>>>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>>>>  struct fpga_manager *
>>>> -fpga_mgr_register(struct device *parent, const char *name,
>>>> -		  const struct fpga_manager_ops *mops, void *priv);
>>>> +__fpga_mgr_register(struct device *parent, const char *name,
>>>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
>>>> +
>>>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>>>>  
>>>> +#define devm_fpga_mgr_register_full(parent, info) \
>>>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>  struct fpga_manager *
>>>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>> +			      struct module *owner);
>>>
>>> Add a line here. I can do it myself if you agree.
>>
>> Sure, that is fine by me. I also spotted a typo in the commit log body
>> (in taken -> is taken). Do you want me to send a v6, or do you prefer
>> to fix that in place?
> 
> No need, I can fix it.
> 
>>
>>>
>>> There is still a RFC prefix for this patch. Are you ready to get it merged?
>>> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
>>
>> I'm ready for the patch to be merged. However, I recently sent an RFC
>> to propose a safer implementation of try_module_get() that would
>> simplify the code and may also benefit other subsystems. What do you
>> think?
>>
>> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/
> 
> I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
> proposal is applied before the end of this cycle, we could re-evaluate
> this patch.

That's fine by me.

Thanks,
Marco


