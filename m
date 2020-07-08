Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60570218FE7
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Jul 2020 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGHSrt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Jul 2020 14:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgGHSrr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 8 Jul 2020 14:47:47 -0400
Received: from [192.168.1.26] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A5120786;
        Wed,  8 Jul 2020 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594234066;
        bh=2uSG0t2YmRHLEmxRcypEIRroELoGimw9U9d+Xr4ZGus=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W3lbJDL+MwORmPfom6ckuoowJu1w46H7yQ5Ox8S4MJtmgL9japkFLheENhRWOc7YY
         wGfqQxQADW54+mtKmXRo7dQk9N6D3ZE8OusIX5f2DLrbIgqBUsW1oEuyLkb7bbrISe
         +4DcBOFhFScsx0k0gl/JXHZaNfXKlty25XHTurlA=
Subject: Re: [PATCH] fpga: stratix10-soc: make FPGA task un-interruptible
To:     Richard Gong <richard.gong@linux.intel.com>, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        richard.gong@intel.com
References: <1594138447-21488-1-git-send-email-richard.gong@linux.intel.com>
 <3e45e4a4-f002-ecf8-110f-bf7d646a5dbe@kernel.org>
 <5be15818-9170-b2a5-e92b-bbe6b1fcba21@linux.intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <39936d44-a802-8105-7d60-97a1e44c163d@kernel.org>
Date:   Wed, 8 Jul 2020 13:47:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5be15818-9170-b2a5-e92b-bbe6b1fcba21@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 7/8/20 1:30 PM, Richard Gong wrote:
> Hi Dinh,
> 
> 
> On 7/8/20 12:08 PM, Dinh Nguyen wrote:
>> Hi
>>
>> On 7/7/20 11:14 AM, richard.gong@linux.intel.com wrote:
>>> From: Richard Gong <richard.gong@intel.com>
>>>
>>> When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
>>> reconfiguration process stops and the user can't perform a new FPGA
>>> reconfiguration properly.
>>>
>>> Set FPGA complete task to be not interruptible so that the user can
>>> properly perform FPGA reconfiguration after CTRL+C event.
>>>
>>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>>> ---
>>>   drivers/fpga/stratix10-soc.c | 23 +++--------------------
>>>   1 file changed, 3 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>>> index 44b7c56..657a70c 100644
>>> --- a/drivers/fpga/stratix10-soc.c
>>> +++ b/drivers/fpga/stratix10-soc.c
>>> @@ -196,17 +196,13 @@ static int s10_ops_write_init(struct
>>> fpga_manager *mgr,
>>>       if (ret < 0)
>>>           goto init_done;
>>>   -    ret = wait_for_completion_interruptible_timeout(
>>> +    ret = wait_for_completion_timeout(
>>>           &priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>>>       if (!ret) {
>>>           dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>>>           ret = -ETIMEDOUT;
>>>           goto init_done;
>>>       }
>>> -    if (ret < 0) {
>>> -        dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
>>> -        goto init_done;
>>> -    }
>>>         ret = 0;
>>>       if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
>>> @@ -318,7 +314,7 @@ static int s10_ops_write(struct fpga_manager
>>> *mgr, const char *buf,
>>>            */
>>>           wait_status = 1; /* not timed out */
>>>           if (!priv->status)
>>> -            wait_status = wait_for_completion_interruptible_timeout(
>>> +            wait_status = wait_for_completion_timeout(
>>>                   &priv->status_return_completion,
>>>                   S10_BUFFER_TIMEOUT);
>>>   @@ -340,13 +336,6 @@ static int s10_ops_write(struct fpga_manager
>>> *mgr, const char *buf,
>>>               ret = -ETIMEDOUT;
>>>               break;
>>>           }
>>> -        if (wait_status < 0) {
>>> -            ret = wait_status;
>>> -            dev_err(dev,
>>> -                "error (%d) waiting for svc layer buffers\n",
>>> -                ret);
>>> -            break;
>>> -        }
>>>       }
>>>         if (!s10_free_buffers(mgr))
>>> @@ -372,7 +361,7 @@ static int s10_ops_write_complete(struct
>>> fpga_manager *mgr,
>>>           if (ret < 0)
>>>               break;
>>>   -        ret = wait_for_completion_interruptible_timeout(
>>> +        ret = wait_for_completion_timeout(
>>>               &priv->status_return_completion, timeout);
>>>           if (!ret) {
>>>               dev_err(dev,
>>> @@ -380,12 +369,6 @@ static int s10_ops_write_complete(struct
>>> fpga_manager *mgr,
>>>               ret = -ETIMEDOUT;
>>>               break;
>>>           }
>>> -        if (ret < 0) {
>>> -            dev_err(dev,
>>> -                "error (%d) waiting for RECONFIG_COMPLETED\n",
>>> -                ret);
>>> -            break;
>>> -
>>>           /* Not error or timeout, so ret is # of jiffies until
>>> timeout */
>>>           timeout = ret;
>>>           ret = 0;
>>>
>>
>> Do you need the same change in drivers/fpga/socfpga.c? 
> It is not required.

Why not?

> Also, you did not
>> include Moritz Fisher on this. He's the maintainer.
>>
> I did include Moritz Fisher <mdf@kernel.org> in the submission, is
> something change recently?
> 

My bad, I didn't see his name in the email.

Dinh
