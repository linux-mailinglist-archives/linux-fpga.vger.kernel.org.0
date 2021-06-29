Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C503B7A6D
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Jun 2021 00:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhF2Wbd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Jun 2021 18:31:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:62795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbhF2Wbc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 18:31:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="188630497"
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="188630497"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 15:29:04 -0700
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="456973543"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 15:29:03 -0700
Date:   Tue, 29 Jun 2021 15:30:41 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <mhu@silicom.dk>,
        Moritz Fischer <mdf@kernel.org>,
        =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>,
        Tom Rix <trix@redhat.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH v2 3/5] spi: spi-altera-dfl: support n5010 feature
 revision
In-Reply-To: <DM6PR11MB38198441F212D6959B676C6D85029@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2106291511040.1279832@rhweight-WRK1>
References: <20210625074213.654274-1-martin@geanix.com> <20210625074213.654274-4-martin@geanix.com> <YNoJSxnm4g1vufbB@epycbox.lan> <e4f0b534-903c-c95d-876e-389c8fc4852c@silicom.dk>
 <DM6PR11MB38198441F212D6959B676C6D85029@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1112206393-1625005841=:1279832"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1112206393-1625005841=:1279832
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Tue, 29 Jun 2021, Wu, Hao wrote:

>> On 28/06/2021 19.39, Moritz Fischer wrote:
>>> On Fri, Jun 25, 2021 at 09:42:11AM +0200, Martin Hundebøll wrote:
>>>> From: Martin Hundebøll<mhu@silicom.dk>
>>>>
>>>> The Max10 BMC on the Silicom n5010 PAC is slightly different than the
>>>> existing BMC's, so use a dedicated feature revision detect it.
>>>>
>>>> Signed-off-by: Martin Hundebøll<mhu@silicom.dk>
>>>> ---
>>>>
>>>> Changes since v1:
>>>>   * use feature revision from struct dfl_device instead of reading it
>>>>     from io-mem
>>>>
>>>>   drivers/spi/spi-altera-dfl.c | 15 +++++++++++++--
>>>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
>>>> index 3e32e4fe5895..f6cf7c8d9dac 100644
>>>> --- a/drivers/spi/spi-altera-dfl.c
>>>> +++ b/drivers/spi/spi-altera-dfl.c
>>>> @@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
>>>>   	.chip_select = 0,
>>>>   };
>>>>
>>>> +static struct spi_board_info m10_n5010_bmc_info = {
>>>> +	.modalias = "m10-n5010",
>>>> +	.max_speed_hz = 12500000,
>>>> +	.bus_num = 0,
>>>> +	.chip_select = 0,
>>>> +};
>>> Is there no way to query the mc for version info?
>>
>> Do you mean reading the BMC variant (i.e. n5010 / d5005 / n3000) from a
>> register?
>>
>> Not in a uniform way across the different boards that I'm aware of. But
>> isn't this what the DFL feature revision is meant for?
>
> If this is used to distinguish different boards, then revision (4bits?) may not

On the one hand, the revision is being used to distinguish the board. 
More precisely, the feature ID id determining the actual hardware 
involved, altera-spi connected to a particular indirect register mailbox. 
This is a different feature id used by the n3000 which has a different 
indirect register mailbox with a NIOS hanshake.  So in this case the revision
is being used to specify remote end of the SPI connection, d5005 BMC vs. 
n5010 BMC.

I think in this case 4 bits is enough.  We've only had two instances 
of this hardware in 5 years.  Certainly any future instances of this
hardware should have a register describing the remote end of the SPI 
connection.  This hardware change would then require a new feature id.

> be enough. New version DFH may be able to resolve this limitation, but it
> is always encouraged to have its own method to tell if possible, not depending
> on DFH, it makes this IP easy to be reused in non DFL case.
>
> Thanks
> Hao
>
>>
>> // Martin
>
--8323328-1112206393-1625005841=:1279832--
