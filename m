Return-Path: <linux-fpga+bounces-403-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D99897158
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Apr 2024 15:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B768DB27C9D
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Apr 2024 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603E148304;
	Wed,  3 Apr 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibN4/w2c"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB914830F
	for <linux-fpga@vger.kernel.org>; Wed,  3 Apr 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151629; cv=none; b=Jjm1gp03jKqp9KJXUfdSIe9jsouZ9ACmGDPJU7KtlzhsPpsGe8n1ATpF3RUkZC+PvqzsLfzTdcntDPahaqc6tBKpHQPfh75bDAkt1YzGtR/MfOQE260WzdS+YiTBKjY1lD+5ub0qIY+gXlgymo1YojyvmzuhctOoe0AVKmZ8X8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151629; c=relaxed/simple;
	bh=vvXjnTWhbK/AP27SJS5neO8uglMhuxHEZbqOiLd+OwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o07uNTgUGk31qvAT5WF0CcVGY3acmt/b/BHC/QXzcX5DPsrU1/V2xi9MBh0txermrdbI/XKT+l3dZ6ZC3ci+F2QJuNR/+N21rIPTKybCql9oPcOW/HjYdySRAzBH1YWJL5Kiz8Cjp3rhKXOSYdacn9mTPWhVtxD9q89LFc5PG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibN4/w2c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712151626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kFvPsELnPBycEMhpctHKr6AzjIToWfAkKobOxDoJu0=;
	b=ibN4/w2cr8bz9MYX3f0ZnpOAVLse/Sewmouys40KNdcUvFnLllTl6qrwmaye2KoC5ArKbh
	3JT9Qm3KO2lbH19RkTbuFHLrLhpaG7efquihtl+mF0A4bIwnIyzPNwjkKQ5MK+do5SKfJX
	YvYLcXU+mkUiDmcOIvZ+lpnTx57t1fs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-YiXvn3_fOkaKpeNMmIMNTA-1; Wed, 03 Apr 2024 09:40:25 -0400
X-MC-Unique: YiXvn3_fOkaKpeNMmIMNTA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5a9cf374c45so129140eaf.3
        for <linux-fpga@vger.kernel.org>; Wed, 03 Apr 2024 06:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151624; x=1712756424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kFvPsELnPBycEMhpctHKr6AzjIToWfAkKobOxDoJu0=;
        b=pA/UsOKcJbS12S7fiJwrMl/fzpSBaIVEACOWp7hG2aLO68jN1sUIJou62aeSs64pFP
         7YoANI+UyLXJG3TuunXpyegIkYbPHCIfJNTNS2igBa6ojys7Ouz8ejW82+HHfrDt2le5
         YGucDQqWB2ljAp7CKHzJBNgjsmOt7o5+bq1nMMDHp8vXw0gWqAw/kYZE4SM6zNBB8FMj
         thSZWSP8QYVtkv5roMA1V9MpNDn3UhD9BPoDNAcDn8tOTQcbPQ9C+pEZEYwclyKIse0+
         0ZJzqUo5HTHbtpRxBbtFt/h7jDjDT2HMwAxa1HoiNpVHzrRVL37wvq6hjfq49UVfT0+S
         Cgfw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9k15jUx9c51ry/CUKzS2SgOdt8uIBrnzvjvE7NmyuRxl7EDKjR4nqD5b5EUdASzjFlGC6XgWYaai16J9hYKbNclbFF3EgOT04g==
X-Gm-Message-State: AOJu0Yz/JbNSMXdpLeRt9TkxaNMeBQAX1qgrdPYNeBnITw3YZTW0VERX
	ozI1GqcZrOsmta6KtmShRtOsKN6jSTJXDS3WKlSO9zXMkZM0/nXr27b9axizgGb7BbPT4YKlHLI
	ADoW7jf7ZV2v/ZdsKHmW6mV9OivOPieSwtsig/fTACipgv/WhwBqzFkfWdw==
X-Received: by 2002:a05:6358:342a:b0:17e:6a4d:777 with SMTP id h42-20020a056358342a00b0017e6a4d0777mr19134535rwd.19.1712151624784;
        Wed, 03 Apr 2024 06:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJfrdTcs7yrYrpjS2ZFxR2zgJ4gJKVUQWgLsmQEIoC2FQZOcDQy0V078Vo7dbZFQ4bbGUhPA==
X-Received: by 2002:a05:6358:342a:b0:17e:6a4d:777 with SMTP id h42-20020a056358342a00b0017e6a4d0777mr19134521rwd.19.1712151624512;
        Wed, 03 Apr 2024 06:40:24 -0700 (PDT)
Received: from [192.168.9.34] (net-2-34-25-239.cust.vodafonedsl.it. [2.34.25.239])
        by smtp.gmail.com with ESMTPSA id qp10-20020a05620a388a00b0078d3ad47448sm229648qkn.104.2024.04.03.06.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:40:23 -0700 (PDT)
Message-ID: <9d49402e-c5d4-4002-954f-7d2c48fdcfe4@redhat.com>
Date: Wed, 3 Apr 2024 15:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: tests: use KUnit devices instead of platform
 devices
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329174849.248243-1-marpagan@redhat.com>
 <ZgujpnLfHTp+WRNL@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZgujpnLfHTp+WRNL@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-02 08:20, Xu Yilun wrote:
> On Fri, Mar 29, 2024 at 06:48:47PM +0100, Marco Pagani wrote:
>> KUnit now provides helper functions to create fake devices, so use them
>> instead of relying on platform devices.
>>
>> Other changes: remove an unnecessary white space in the fpga region suite.
>>
>> Reviewed-by: Russ Weight <russ.weight@linux.dev>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> Does this patch has dependency on module owner changes for fpga-mgr/bridge/region?

There is no dependency on module owner changes for mgr/bridge/region.

Thanks,
Marco


