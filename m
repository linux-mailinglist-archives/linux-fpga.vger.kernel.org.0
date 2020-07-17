Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF53223CCD
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jul 2020 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgGQNch (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Jul 2020 09:32:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25722 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726079AbgGQNcf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Jul 2020 09:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594992753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gw7Bdg5F6PTJRpZOqnV/ZVS3jnjuaxd2N0oczZTUZYw=;
        b=DgdeZi30iIn5ceFQjYSg7ehWyuPTcH8ROUVVw2Ou942xepVaonmU9Mb5myx5Vr4ACY2e3u
        y16uY20jMQCKN85k8iEAp3R0nyyEZEFSO315YroYclAunNm54Rk2Dctm1i45V+mZF9A1oC
        BGcsNOofuPOVehrf3KY8R1AhZdQqKTQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-a7f535u5OZmDoQiG17eZsQ-1; Fri, 17 Jul 2020 09:32:29 -0400
X-MC-Unique: a7f535u5OZmDoQiG17eZsQ-1
Received: by mail-qk1-f197.google.com with SMTP id f79so6024427qke.9
        for <linux-fpga@vger.kernel.org>; Fri, 17 Jul 2020 06:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gw7Bdg5F6PTJRpZOqnV/ZVS3jnjuaxd2N0oczZTUZYw=;
        b=iSTepsA5el2jQ6G51O/GIcMMmUzs2lpk56Js7Zw57MkJEEh2xWdxehtHhVu3Rd5cqL
         J4y30eBdZwgXvIqYm4ldRUgiQX0WovcgU27ObdZWdQrxMWHyP+4pMGRkZYdnR/gB6f0M
         KiusmDkdyJDNcboljRjBe14gOFBRvb6saTkkKhMy5np6wU6CdeVSh2f2H7pDcnqhPtfF
         /kXsXAfj4Xjf6OezNNbUUyv3mhnX73LIQnp35ieaWx0vYElPMeOaeFZ0FoYwDvoIHzMe
         qWSsfqpDQid4lxxrSfLsjoOsOZ75H8O5YxS/g9tJqCmIJELWfqR+1QqsHm+zGToYLScP
         x1RQ==
X-Gm-Message-State: AOAM530Q2jPbRJa5BQUQYt6iF/nonC37uhYm9b5u2WYxUzdC5UV09lhu
        eyWXoG1j4HHE9OccC2DDFKNBQzodBKqwgeJXymeFFr+WRSCLhkDaDv26IC5MPREPyF4FJkd4dDp
        l9EmzxEPoR0Urh//otHbWzw==
X-Received: by 2002:ac8:1305:: with SMTP id e5mr10471765qtj.78.1594992749436;
        Fri, 17 Jul 2020 06:32:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVukT5N1A8RHevyQUfkREmmAlrpMLsNUwqg40Hvp+6mZmIfyRmX1j7yE1q3Z+1fCBkwQPYqw==
X-Received: by 2002:ac8:1305:: with SMTP id e5mr10471725qtj.78.1594992749028;
        Fri, 17 Jul 2020 06:32:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j24sm9568765qkl.79.2020.07.17.06.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 06:32:28 -0700 (PDT)
Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
 <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <237c776b-8746-421d-26ad-eea7242a9172@redhat.com>
Date:   Fri, 17 Jul 2020 06:32:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/16/20 8:48 PM, Wu, Hao wrote:
>> Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
>>
>> Generally i think this is a good approach.
>>
>> However I do have concern.
>>
>> The feature_id in dfl is magic number, similar to pci id but without a vendor
>> id.
>>
>> Is it possible to add something like a vendor id so different vendors would
>> not have to be so careful to use a unique id ?
> Hi Tom,
>
> Thanks for the comments.
>
> Here is only one field defined in spec, that is feature id to distinguish one
> feature with another one. There is no vendor id here I think, and several
> cards are using this for now and seems not possible to change DFH format
> for these products. : (

There looks like some unused bits in the first word, how about

#define DFH_EOL            BIT_ULL(40)        /* End of list */

+define DFH_VENDOR    GENMAKE_ULL(49,41) /* Vendor ID */

#define DFH_TYPE        GENMASK_ULL(63, 60)    /* Feature type */

And Intel gets id 0.

>
> I fully understand the concern is the feature id management, and potential
> conflicts there from different vendors. One possible method to resolve this
> is managing the ids in a public place (web? Or just the driver header file for
> feature id definition), all vendors can request some feature ids, and other
> people can see which feature ids have been used so that they can avoid
> using conflict ones with other people.

The conflict will come in development when two vendors use the same unpublished feature id.

Also keeping the truth of id's in the kernel source isn't that great because the public kernel always lags development repositories.

>
> And in the later version DFH, this feature id will be replaced with GUID
> I think, so it can resolve the conflict problems from different vendors?
> But now, we still need to handle the existing ones. : )

This is why I proposed needing to generalize the matching.

>
> Thanks
> Hao
>
>> This touches some of the matching function of the bus ops.  Could there be a
>> way for bus ops to be used so that there could be multiple matching
>> function.  Maybe the one in 0002 as a default so users could override it ?
>>
>> The use case I am worrying about is an OEM.  The OEM uses an unclaimed
>> feature_id and supplies their own platform device device driver to match the
>> feature_id.  But some later version of the kernel claims this feature_id and
>> the OEM's driver no longer works and since the value comes from pci config
>> space it is difficult to change.
>>
>> So looking for something like
>>
>> register_feature_matcher((*bus_match)(struct device *dev, struct
>> device_driver *drv))
>>
>> static int dfl_bus_match_default(struct device *dev, struct device_driver *drv)
>> {
>>     struct dfl_device *dfl_dev = to_dfl_dev(dev);
>>     struct dfl_driver *dfl_drv = to_dfl_drv(drv);
>>     const struct dfl_device_id *id_entry = dfl_drv->id_table;
>>
>>     while (id_entry->feature_id) {
>>         if (dfl_match_one_device(id_entry, dfl_dev)) {
>>             dfl_dev->id_entry = id_entry;
>>             return 1;
>>         }
>>         id_entry++;
>>     }
>>
>>     return 0;
>> }
>>
>> register_feature_matcher(&dfl_bus_match_default)
>>
>> static int dfl_bus_match(struct device *dev, struct device_driver *drv)
>> {
>>
>>     struct dfl_device *dfl_dev = to_dfl_dev(dev);
>>     struct dfl_driver *dfl_drv = to_dfl_drv(drv);
>>     const struct dfl_device_id *id_entry = dfl_drv->id_table;
>>
>>     while (id_entry->feature_id) {
>>
>>         matcher = Loop over matchers()
>>
>>         if (matcher(dev, drv)) {
>>             dfl_dev->id_entry = id_entry;
>>             return 1;
>>         }
>>         id_entry++;
>>     }
>>
>>     return 0;
>> }
>>
>> Or maybe use some of the unused bits in the dfl header to add a second
>> vendor-like id and change existing matcher to look feature_id and
>> vendor_like_id.
>>
>> Tom
>>
>>
>>
>> On 7/14/20 10:38 PM, Xu Yilun wrote:
>>> This patchset makes it possible to develop independent driver modules
>>> for DFL private features. It also helps to leverage existing kernel
>>> drivers to enable some IP blocks in DFL.
>>>
>>> Xu Yilun (2):
>>>   fpga: dfl: map feature mmio resources in their own feature drivers
>>>   fpga: dfl: create a dfl bus type to support DFL devices
>>>
>>>  Documentation/ABI/testing/sysfs-bus-dfl |  15 ++
>>>  drivers/fpga/dfl-pci.c                  |  21 +-
>>>  drivers/fpga/dfl.c                      | 435 +++++++++++++++++++++++++++-----
>>>  drivers/fpga/dfl.h                      |  91 ++++++-
>>>  4 files changed, 492 insertions(+), 70 deletions(-)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
>>>

