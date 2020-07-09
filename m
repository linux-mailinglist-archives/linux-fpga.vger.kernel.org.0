Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8593121A067
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jul 2020 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgGINAr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Jul 2020 09:00:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21729 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726320AbgGINAr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 9 Jul 2020 09:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594299645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YSXgeEhLv5Tj53wSYbt5UYfNvPxCwCEac8F+A/0zihk=;
        b=FJbU4R0XqEliESkc7t+Q9biPfIp7OnZKYGcGIS7l+P1vgLVFBv0nrcJYNZTklHj+uYuSnv
        dAmqz1tJep5B2sbdL7+uu4ak9FQsE39BnjGpYnFpWr1dw+2bq5TPUodTxrCxpBGaYXwoi6
        PXSuT51icoEQdBq5KhbAbP6MwBpVEPw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-5s6Do-xePiWdXNH7yrqvlQ-1; Thu, 09 Jul 2020 09:00:44 -0400
X-MC-Unique: 5s6Do-xePiWdXNH7yrqvlQ-1
Received: by mail-qk1-f200.google.com with SMTP id k1so1671873qko.14
        for <linux-fpga@vger.kernel.org>; Thu, 09 Jul 2020 06:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YSXgeEhLv5Tj53wSYbt5UYfNvPxCwCEac8F+A/0zihk=;
        b=nVSawxD8PjVSTIsD/7TTNg/21i84ul+Q4WmIdAGbiTO7H2mwnKrtf036SKfiWKvo/B
         JaiW6bJmX6Zr1wDtyCGtWlRgPSE9Qk4gOSpMbvL02PYm4e5bOkOvnLDuhkVzIsp6i9xV
         xa0GdN/MqM4KuaHwcfVUdSfwV/bXRBXrqvVkXjEKf8n6+JIHVTxDvFKbYDJIbfybylTu
         SnqlOJ08fI38M8pNLsjEZPUgpgIpNDQxTGJszN7U6wCQ0AC3LENFcZPJkVLPNROLP0wU
         sOso6HF9Ds0/f+t7oTqq/S2p2PH1EkJ+9G31flxH9zsZtIVaePtY5gX9rt9nNEbmHcjn
         ChOQ==
X-Gm-Message-State: AOAM533FvDP1EkVd0B23QKeTEUd7JhAn1d3gZqSrE3by9wClY3MGp2If
        qsgO9HAhoK5Ft7C3VA2O5ky83SY/QB4UgWJCJEMW5QWwzL6Tum2DhRxLNxPECnJtgO6ae5TKixO
        844JNLjgy/Ch7kw7SSmfOYQ==
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr63937043qkw.20.1594299643820;
        Thu, 09 Jul 2020 06:00:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmIIe/1yIwX7BG5ThjTMW2ZaJ1OANij7ZtdWK/gj/VJQ69fGc/AlUQ8twBBUU4xG8b7PG2Mg==
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr63937011qkw.20.1594299643609;
        Thu, 09 Jul 2020 06:00:43 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t57sm3684437qtc.91.2020.07.09.06.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:00:42 -0700 (PDT)
Subject: Re: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
References: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200709093527.GA32541@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819D07348C347B5BB8F86C085640@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2d7919d5-a320-58f4-5c9d-7ef868ad8676@redhat.com>
Date:   Thu, 9 Jul 2020 06:00:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3819D07348C347B5BB8F86C085640@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/9/20 3:14 AM, Wu, Hao wrote:
>> On Thu, Jul 09, 2020 at 05:10:49PM +0800, Wu, Hao wrote:
>>>> Subject: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
>>>>
>>>> Add PCIe Device ID for Intel FPGA PAC N3000.
>>>>
>>>> Signed-off-by: Wu Hao <hao.wu@intel.com>
>>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> ---
>>>>  drivers/fpga/dfl-pci.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>>>> index 73b5153..824aecf 100644
>>>> --- a/drivers/fpga/dfl-pci.c
>>>> +++ b/drivers/fpga/dfl-pci.c
>>>> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>>>>  #define PCIE_DEVICE_ID_PF_INT_5_X0xBCBD
>>>>  #define PCIE_DEVICE_ID_PF_INT_6_X0xBCC0
>>>>  #define PCIE_DEVICE_ID_PF_DSC_1_X0x09C4
>>>> +#define PCIE_DEVICE_ID_PF_PAC_N3000 0x0B30
>>> Should we drop _PF_ here? and also do you want _INTEL_ here?
>> I think we could keep _PF_, also there is no need to support VF of pac
>> n3000 in product now, but it does exist (ID: 0x0b31).

I was wondering about the vf id, thanks!

>>
>> And add _INTEL_ is good to me.
>>
>> Then how about this one:
>>   #define PCIE_DEVICE_ID_PF_INTEL_PAC_N3000	0x0B30
> I am just considering the alignment with ids defined in include/linux/pci_ids.h
> So drop _PF_ before _INTEL_ would be better? : )

To be consistent, all the id's are intel and all could drop pf.

Tom

>
> Thanks
> Hao
>

