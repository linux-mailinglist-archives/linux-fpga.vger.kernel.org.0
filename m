Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B689720D772
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jun 2020 22:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbgF2TaF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Jun 2020 15:30:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732692AbgF2TaF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Jun 2020 15:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593459003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rozIRZd2Z+z5ejQC/EdCJboYjDdy+vJEupYT4pSKo0=;
        b=E4zY2/l8tSL/sUsqGHzCmUy2h9/YGRY360wGDOpUn6HEvdpEewVXksPYClYZeC+z5bYvOx
        KYkEou1YIyBtPO93jyrDNQoGNI6g+bIweAIsqBipXtt47XEQXQuxiOloUVkIvD09ElKV59
        Jss2CJnVuIq7K14PDhTrZUmrvQZVGZY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-l5Wzzcl7OIa-t3xBiuXAMg-1; Mon, 29 Jun 2020 09:28:07 -0400
X-MC-Unique: l5Wzzcl7OIa-t3xBiuXAMg-1
Received: by mail-qv1-f72.google.com with SMTP id g17so10024285qvw.0
        for <linux-fpga@vger.kernel.org>; Mon, 29 Jun 2020 06:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/rozIRZd2Z+z5ejQC/EdCJboYjDdy+vJEupYT4pSKo0=;
        b=DlT3P7a4wcBt/O2xIkhc5s5Z/OXwspurISv+AGrKqhCxFGAyF3zHfme9fDbcoaJ16d
         tay7JDnrt7qyy15Z4VhLZ+L6E08SCpd7fJ41qw5uZAfm0gfQciKQXH2aQC3zRjYQ5quJ
         ZF8CTFxNl33YadN2N3JrFj7XQ9NGHmV/+AzSNwfCNhWmxnjFUakrX2QJLrSc3GNSxSHI
         PxcXQeXj7TFtYO7rhE4QlgPnYkT4QeIRgZmdHgvwa9PI0GlShtClDpswSwqiERn3ECtJ
         ivs91wL2qgVm8RpIBajt10rj3KFsCMnJ1xnXD5PLFjkT2AKlBCasnTOrmpzuPfnWi4JL
         V4VA==
X-Gm-Message-State: AOAM531nZ9PaFpMYserRMUmAdyHJarus+rKWHjMgKyXQNCY+fbCE9KmD
        XsLVIFdd9dHmWGIYRD34FL2zVRsiKyaYvMd227HQhVMZAdM6VEykkbS4FJ4Vltl+B1N5/rEj9K5
        TVWViHLjzW4HZNOFseCuO9g==
X-Received: by 2002:a0c:b246:: with SMTP id k6mr15065269qve.146.1593437287343;
        Mon, 29 Jun 2020 06:28:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwms1o8tyqQwrkXCJ8cIREd5x9uNk+bPTzS0ou0s1jv5IQbRinAHtIoLnXqHLMHBn8uHQRMvg==
X-Received: by 2002:a0c:b246:: with SMTP id k6mr15065252qve.146.1593437287140;
        Mon, 29 Jun 2020 06:28:07 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x13sm17008095qts.57.2020.06.29.06.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 06:28:06 -0700 (PDT)
Subject: Re: [PATCH] fpga: dfl: improve configuration of dfl pci devices
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
References: <20200628151813.7679-1-trix@redhat.com>
 <20200629021924.GB2620@yilunxu-OptiPlex-7050>
 <DM6PR11MB38196ED29A3E0BBAD7B246C1856E0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <26b7c920-7b9f-b753-4a49-258e09b771fa@redhat.com>
Date:   Mon, 29 Jun 2020 06:28:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38196ED29A3E0BBAD7B246C1856E0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/28/20 8:12 PM, Wu, Hao wrote:
>> -----Original Message-----
>> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
>> On Behalf Of Xu Yilun
>> Sent: Monday, June 29, 2020 10:19 AM
>> To: trix@redhat.com
>> Cc: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Wu, Hao <hao.wu@intel.com>;
>> matthew.gerlach@linux.intel.com
>> Subject: Re: [PATCH] fpga: dfl: improve configuration of dfl pci devices
>>
>> I think maybe we don't have to select them all. It is now possible for
>> FPGA DFL boards to work without FME or AFU, providing limited
>> functionality. It is possible designers trim the bitstream for their
>> purpose, and also need a smaller driver set.
>>
> Yes, we hope that this dfl-pci could be a common module shared by
> different cards. Some device doesn't have FME, e.g. some VF device
> with AFU only, some device has FME, but no PR support, and in the
> future, it's possible to add new modules, or something replacing AFU
> or FME, so we don't have to select all here.
>
>> I think we may add "default FPGA_DFL" for FPGA_DFL_FME,
>> FPGA_DFL_FME_MGR and others to make life easier.
> It's hard to say it's easier for everybody, e.g. I am a user of N3000, but
> I have to unselect the PR modules, as they are default Yes as proposed?
> Maybe it's better to let user select what they want, unless we find
> something really common needed under DFL framework.

I get your point about n3000, but that card is not currently supported in the public. Currently there is really only pac10, the 0x9c4 device.  Once n3000 (and d5005) is out, it will have several sub devices that will also so need to be manually configured.  While a developer of the n3000 will know which subdevices are needed, someone just building the kernel will not.  So would expect there to be something like

CONFIG_FPGA_DFL_N3000

select CONFIG_DFL_PCI

select CONFIG_DFL_SUBDEV_1

..

On PF vs FP, yes only afu parts are needed.  But i doubt anyone builds a VF specific kernel. And if folks wanted to not use the fme parts they would not have to load it's module at run time.

I would like a top level config what auto selects all of the submodules needed based on the card. I think maybe that is CONFIG_FPGA_DFL_PAC10. so we will be ready for CONFIG_FPGA_DFL_N3000 and CONFIG_FPGA_DFL_D5005 and what ever comes later.

Tom

> Hao
>

