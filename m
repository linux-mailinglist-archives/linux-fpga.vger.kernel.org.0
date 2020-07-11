Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597DF21C52A
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Jul 2020 18:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgGKQVP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Jul 2020 12:21:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42114 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728412AbgGKQVO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Jul 2020 12:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594484472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AlA+cIFYWbndb4gFwhFTCTPyhe+yp/zlSC3gYYxBKw=;
        b=eX3WnpAnSA1qOQHZg2Rfn2yFfm6d9g2hGjLlmHIyVgjvGBDscFIjrrQpRxuSx5QWDNNEfs
        GH5SJzW5loBOmxnQYII/Un4O3yFgReHmtnPxTNcxj6RC3aRlglSEl974wmGBCNJl8pVRar
        GqNaIVpNSpfcVEkPV98pt46GMLQKHt8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-ZtKP3IjRPDSJ7ZOE_xpIaw-1; Sat, 11 Jul 2020 12:21:10 -0400
X-MC-Unique: ZtKP3IjRPDSJ7ZOE_xpIaw-1
Received: by mail-qk1-f198.google.com with SMTP id q192so6998938qka.13
        for <linux-fpga@vger.kernel.org>; Sat, 11 Jul 2020 09:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9AlA+cIFYWbndb4gFwhFTCTPyhe+yp/zlSC3gYYxBKw=;
        b=R1fmBS+D15gCIDX3AmZVzR3PHv5qg/09UxU0jmfXr1+6R8GjRX96FeXE4Q4pbJCyQg
         xffUBkBStatLgIV+FFdL+6A+6urdpJ7InHQ7STwdMp36jLn4ItJlamcJdosqbSJgDvl7
         fEfIuBqrjodfQ3V0cKxiNVcF9T4ynODM67qnH/Putp92f9h3nmW0zRa7hdkFahJPiEIE
         +gcpmlBgQHLYRoIlS9UQ9r3ChwK/E6xwtM55KzAGR/8rsj1g9zJ70TijUUdgBhihMUQ1
         90hjVtGZbZPdjbra2q2kIXRo0k4Sb1YYyyBv6N6UqU/T4Dhr/LX5R0+QfzbKEKbYzbpS
         PLbQ==
X-Gm-Message-State: AOAM5328zZUEw8h+naSf+PVZDldmu/lMSBQUUYpMMs/6gkN+ZIhwBiEA
        zJdSYi+2uw3EX7yJUqucFk0DAjWCcGcNHLcb1zTr5WrKKofCyd08h9NDlhz31Vong/BBk4Ymt2c
        YVfMJqicEwk+j5TrXr/dHwg==
X-Received: by 2002:a37:e217:: with SMTP id g23mr75325306qki.108.1594484470233;
        Sat, 11 Jul 2020 09:21:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5DY2i09z0u+FCwttgEkruzUkoO/ggYfkUMxtuYfMOw2/k500kdqt2X/WRJu192QZGWyek8Q==
X-Received: by 2002:a37:e217:: with SMTP id g23mr75325283qki.108.1594484469913;
        Sat, 11 Jul 2020 09:21:09 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d135sm11795610qkg.117.2020.07.11.09.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2020 09:21:08 -0700 (PDT)
Subject: Re: [RESEND PATCH 1/2] fpga: dfl: pci: reduce the scope of variable
 'ret'
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com
References: <1594282337-32125-1-git-send-email-yilun.xu@intel.com>
 <1594282337-32125-2-git-send-email-yilun.xu@intel.com>
 <ef506ec6-d857-736b-e9e2-46077ab7d778@redhat.com>
 <20200710051600.GA8689@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <85d84892-14d0-3097-c4f9-cbb9092c9a5f@redhat.com>
Date:   Sat, 11 Jul 2020 09:21:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200710051600.GA8689@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ok, i take your point on the api.

However I still feel that this change should be improved so the return is not defined inside a block.

I think this could be done better with

int ret = num_vfs;

...

return ret;

There is no consistency on this check with the other drivers' sriov_configure.

I do not feel strongly about this change, your original change will work. So you may add.

Reviewed-by: Tom Rix <trix@redhat.com>

Tom

On 7/9/20 10:16 PM, Xu Yilun wrote:
> On Thu, Jul 09, 2020 at 06:18:18AM -0700, Tom Rix wrote:
>> I think a better change is to use the ret variable, like this
>>
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -312,7 +312,7 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>> Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â  }
>> Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â  }
>> Ã‚Â 
>> -Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â  return num_vfs;
>> +Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â Ã‚Â  return ret;
>> Ã‚Â }
>>
>> The existing use of returning num_vfs is not right, the function should return 0/err not num_vfs. currently it is reusing the 0 passed in with num_vfs to mean disable as the 0 return status.Ã‚Â  it should be properly returning ret.
> The sriov_configure callback should return negative value for error, and
> return num_vfs if success.
>
> See the Documentation/PCI/pci-iov-howto.rst
>
> also in drivers/pci/iov.c:
>
>   static ssize_t sriov_numvfs_store(struct device *dev, ...)
>   {
> 	...
>
>         ret = pdev->driver->sriov_configure(pdev, num_vfs);
>         if (ret < 0) 
>                 goto exit;
>
>         if (ret != num_vfs)
>                 pci_warn(pdev, "%d VFs requested; only %d enabled\n",
>                          num_vfs, ret);
>
> 	...
>   }
>
>> Tom
>>
>> On 7/9/20 1:12 AM, Xu Yilun wrote:
>>> This is to fix lkp cppcheck warnings:
>>>
>>>  drivers/fpga/dfl-pci.c:230:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
>>>     int ret = 0;
>>>         ^
>>>
>>>  drivers/fpga/dfl-pci.c:230:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
>>>     int ret = 0;
>>>             ^
>>>
>>> Fixes: 3c2760b78f90 ("fpga: dfl: pci: fix return value of cci_pci_sriov_configure")
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> Acked-by: Wu Hao <hao.wu@intel.com>
>>> ---
>>>  drivers/fpga/dfl-pci.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>>> index 4a14a24..73b5153 100644
>>> --- a/drivers/fpga/dfl-pci.c
>>> +++ b/drivers/fpga/dfl-pci.c
>>> @@ -285,7 +285,6 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>>>  {
>>>  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
>>>  	struct dfl_fpga_cdev *cdev = drvdata->cdev;
>>> -	int ret = 0;
>>>  
>>>  	if (!num_vfs) {
>>>  		/*
>>> @@ -297,6 +296,8 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>>>  		dfl_fpga_cdev_config_ports_pf(cdev);
>>>  
>>>  	} else {
>>> +		int ret;
>>> +
>>>  		/*
>>>  		 * before enable SRIOV, put released ports into VF access mode
>>>  		 * first of all.

