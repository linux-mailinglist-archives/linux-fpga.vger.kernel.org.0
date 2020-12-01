Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E72CB0CB
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 00:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgLAXbY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 18:31:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:57103 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgLAXbX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 1 Dec 2020 18:31:23 -0500
IronPort-SDR: WZSWPhxBra9pP+ftUaXprhW334TjQZYD4J+xsTZgSCUnGLbHTu6845lPRSz0qyaqsWPSNZysCT
 u3PJFPcwpBIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="257634759"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="257634759"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 15:30:43 -0800
IronPort-SDR: mEjNizPwsa5Xa8gB8/7KDCBUubNUNqUOfipfUunmzdf8Sff0y6prwzy7yoXnTCASl0fGO3k5bd
 /Sy8cIklZQFg==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="481299500"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.174.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 15:30:42 -0800
Subject: Re: [PATCH v6 2/7] fpga: sec-mgr: enable secure updates
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201106010905.11935-1-russell.h.weight@intel.com>
 <20201106010905.11935-3-russell.h.weight@intel.com>
 <9dd75daf-eb73-4008-ca65-6f7ea3923e35@silicom.dk>
 <c6dc2edb-9639-9c4f-c065-18cade768fb6@intel.com>
 <5b49ef38-2c03-02bc-6a1e-5b663180acf3@silicom.dk>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <25ee1ab1-3d81-d9b9-240d-143a9936d0f8@intel.com>
Date:   Tue, 1 Dec 2020 15:30:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5b49ef38-2c03-02bc-6a1e-5b663180acf3@silicom.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 12/1/20 12:47 AM, Martin Hundebøll wrote:
> Hi Russ,
>
> On 01/12/2020 00.54, Russ Weight wrote:
>> Thanks Martin. I'll work on a fix for this.
>
> Attached is my in-house fix.
>
> // Martin
>
>> On 11/26/20 6:02 AM, Martin Hundebøll wrote:
>>> Hi Russ,
>>>
>>> I found another thing while testing this...
>>>
>>> On 06/11/2020 02.09, Russ Weight wrote:
>>>
>>> <snip>
>>>
>>>> +static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>>> +                  const char *buf, size_t count)
>>>> +{
>>>> +    struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
>>>> +    int ret = count;
>>>> +
>>>> +    if (count == 0 || count >= PATH_MAX)
>>>> +        return -EINVAL;
>>>> +
>>>> +    mutex_lock(&smgr->lock);
>>>> +    if (smgr->driver_unload || smgr->progress != FPGA_SEC_PROG_IDLE) {
>>>> +        ret = -EBUSY;
>>>> +        goto unlock_exit;
>>>> +    }
>>>> +
>>>> +    smgr->filename = kstrndup(buf, count - 1, GFP_KERNEL);
>>>
>>> The `count - 1` is meant to remove a trailing newline, but opae-sdk writes the filename without newline, so better do it conditionally...

After looking at how kstrndup() is used elsewhere, and after
doing some experimentation, I think the best fix may be to just
remove the "- 1":

    smgr->filename = kstrndup(buf, count, GFP_KERNEL);

The code shouldn't have assumed a "\n", and I don't think the
kernel should be required to do white-space cleanup.

Does this fix seem OK to you?

- Russ
>>>
>>>> +    if (!smgr->filename) {
>>>> +        ret = -ENOMEM;
>>>> +        goto unlock_exit;
>>>> +    }
>>>> +
>>>> +    smgr->err_code = FPGA_SEC_ERR_NONE;
>>>> +    smgr->progress = FPGA_SEC_PROG_READING;
>>>> +    reinit_completion(&smgr->update_done);
>>>> +    schedule_work(&smgr->work);
>>>> +
>>>> +unlock_exit:
>>>> +    mutex_unlock(&smgr->lock);
>>>> +    return ret;
>>>> +}
>>>> +static DEVICE_ATTR_WO(filename);
>>>> +
>>>> +static struct attribute *sec_mgr_update_attrs[] = {
>>>> +    &dev_attr_filename.attr,
>>>> +    NULL,
>>>> +};
>>>
>>> Thanks,
>>> Martin
>>

