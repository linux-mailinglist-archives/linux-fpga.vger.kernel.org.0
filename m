Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056642C9368
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 00:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgK3Xze (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Nov 2020 18:55:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:49414 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgK3Xze (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 30 Nov 2020 18:55:34 -0500
IronPort-SDR: rsbKIkT3owHAMiYnf5ZVx3VzSdCz8e13V14K86D0tZocTmbmPMmeolZkOgdig5Bw31bZd/9bdl
 52UuHKQRk8ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="236859437"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="236859437"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:54:53 -0800
IronPort-SDR: Qi+TkTOoMuATfeEMce6g+dzdiZ2QKiuFtlGgg7RLKcP4NUOeYAHOBAPPhBohpbHNRWKSn84SPI
 koNp1kg8sfoA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480858895"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.71.254])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:54:52 -0800
Subject: Re: [PATCH v6 2/7] fpga: sec-mgr: enable secure updates
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201106010905.11935-1-russell.h.weight@intel.com>
 <20201106010905.11935-3-russell.h.weight@intel.com>
 <9dd75daf-eb73-4008-ca65-6f7ea3923e35@silicom.dk>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <c6dc2edb-9639-9c4f-c065-18cade768fb6@intel.com>
Date:   Mon, 30 Nov 2020 15:54:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9dd75daf-eb73-4008-ca65-6f7ea3923e35@silicom.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Thanks Martin. I'll work on a fix for this.

- Russ

On 11/26/20 6:02 AM, Martin Hundebøll wrote:
> Hi Russ,
>
> I found another thing while testing this...
>
> On 06/11/2020 02.09, Russ Weight wrote:
>
> <snip>
>
>> +static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>> +                  const char *buf, size_t count)
>> +{
>> +    struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
>> +    int ret = count;
>> +
>> +    if (count == 0 || count >= PATH_MAX)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&smgr->lock);
>> +    if (smgr->driver_unload || smgr->progress != FPGA_SEC_PROG_IDLE) {
>> +        ret = -EBUSY;
>> +        goto unlock_exit;
>> +    }
>> +
>> +    smgr->filename = kstrndup(buf, count - 1, GFP_KERNEL);
>
> The `count - 1` is meant to remove a trailing newline, but opae-sdk writes the filename without newline, so better do it conditionally...
>
>> +    if (!smgr->filename) {
>> +        ret = -ENOMEM;
>> +        goto unlock_exit;
>> +    }
>> +
>> +    smgr->err_code = FPGA_SEC_ERR_NONE;
>> +    smgr->progress = FPGA_SEC_PROG_READING;
>> +    reinit_completion(&smgr->update_done);
>> +    schedule_work(&smgr->work);
>> +
>> +unlock_exit:
>> +    mutex_unlock(&smgr->lock);
>> +    return ret;
>> +}
>> +static DEVICE_ATTR_WO(filename);
>> +
>> +static struct attribute *sec_mgr_update_attrs[] = {
>> +    &dev_attr_filename.attr,
>> +    NULL,
>> +};
>
> Thanks,
> Martin

