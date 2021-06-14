Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924B03A6D53
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhFNRkJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:40:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:29560 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233178AbhFNRkJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Jun 2021 13:40:09 -0400
IronPort-SDR: 0K5+nJVSaOldVUl8X3+9rpHkJhL8eScP03rX0MTR486arFFpERIG3e7U1z3wn56pj5khEEmrB3
 lhYEtKs0Lq/A==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="186223538"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="186223538"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 10:38:06 -0700
IronPort-SDR: 1/SjHrDv+mFd8hSdfVG7Yh6FemGNmTKCSMk0VnAwUgDwdX68ynh3N0RMGzMSmk5lkT5e+Wunxu
 0INLcb17TqOQ==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="449966692"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.255.228.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 10:38:06 -0700
Subject: Re: [PATCH 2/8] fpga: stratix10-soc: Add missing fpga_mgr_free() call
To:     Greg KH <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
References: <20210614170909.232415-1-mdf@kernel.org>
 <20210614170909.232415-3-mdf@kernel.org> <YMeSG6puw7/4OZ6b@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <e7aef991-cd78-15fd-fdc9-9b75709af8c7@intel.com>
Date:   Mon, 14 Jun 2021 10:38:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMeSG6puw7/4OZ6b@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/14/21 10:30 AM, Greg KH wrote:
> On Mon, Jun 14, 2021 at 10:09:03AM -0700, Moritz Fischer wrote:
>> From: Russ Weight <russell.h.weight@intel.com>
>>
>> The stratix10-soc driver uses fpga_mgr_create() function and is therefore
>> responsible to call fpga_mgr_free() to release the class driver resources.
>> Add a missing call to fpga_mgr_free in the s10_remove() function.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>  drivers/fpga/stratix10-soc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>> index 657a70c5fc99..9e34bbbce26e 100644
>> --- a/drivers/fpga/stratix10-soc.c
>> +++ b/drivers/fpga/stratix10-soc.c
>> @@ -454,6 +454,7 @@ static int s10_remove(struct platform_device *pdev)
>>  	struct s10_priv *priv = mgr->priv;
>>  
>>  	fpga_mgr_unregister(mgr);
>> +	fpga_mgr_free(mgr);
>>  	stratix10_svc_free_channel(priv->chan);
>>  
>>  	return 0;
>> -- 
>> 2.31.1
>>
> Does this fix a specific commit?  Does it need a Fixes: and cc: stable
> line too?
It fixes:

e7eef1d7633a fpga: add intel stratix10 soc fpga manager driver

And yes, I think it needs the Fixes: and cc: stable lines

Moritz: Let me know if you want me to add the tags

Greg: Patch 1 in this series could be viewed as a fix for a particular
commit as well, but the code being deleted is harmless/unused. I'm
assuming it does NOT need the Fixes: and cc: stable lines?

- Russ

>
> thanks,
>
> greg k-h

