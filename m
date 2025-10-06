Return-Path: <linux-fpga+bounces-1372-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD23BBEFAC
	for <lists+linux-fpga@lfdr.de>; Mon, 06 Oct 2025 20:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1CEA4F0F5A
	for <lists+linux-fpga@lfdr.de>; Mon,  6 Oct 2025 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93AB2376EB;
	Mon,  6 Oct 2025 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b-kalm-com.20230601.gappssmtp.com header.i=@b-kalm-com.20230601.gappssmtp.com header.b="O9XmLMsI"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2235246BC5
	for <linux-fpga@vger.kernel.org>; Mon,  6 Oct 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775599; cv=none; b=UMbAx+HXEmi52DqRT7/ZERNHUqmco3Sqi3SxkHVdxDe84FhRPhkUhyH1LsS9xYgbHJAfjRQ2skR6F8uiEwERw9S1ayq1+wlnKZ6Gu88JCrd87Zcd083RWatJoieBW6gVUSiM4+BN+lJZNvkQdYUQnQ0lvHpH8wPiqxxCWpP42/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775599; c=relaxed/simple;
	bh=/vpyCahNt9kM638POJH/Jg2Ktgf7aSQD5yYuJTMrDCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTKjVfM4M4pqijWAeC08T3aeEMy+fSC55yxZvRK9Dy0uhaitX7fR3SBjus0P8AMK69pmtl2KYDHuommF33fPRi+MoVvZU2NDawASJtnDsSuKF9lzTLTvl2TtMCNEmVQMiQJj8Ss2iIKQBO6EKVhwfgRF5QXhsc57Pz07G4kX9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b-kalm.com; spf=pass smtp.mailfrom=b-kalm.com; dkim=pass (2048-bit key) header.d=b-kalm-com.20230601.gappssmtp.com header.i=@b-kalm-com.20230601.gappssmtp.com header.b=O9XmLMsI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b-kalm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b-kalm.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f4319b8c03so325873f8f.0
        for <linux-fpga@vger.kernel.org>; Mon, 06 Oct 2025 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=b-kalm-com.20230601.gappssmtp.com; s=20230601; t=1759775596; x=1760380396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3HHtGW+DSGKKUt7QI/vBAabeCHRr+hIur1q0oYGuCk=;
        b=O9XmLMsI9LNQiDG1IFqIp9A2zgnexCNiF8sKQXVLhV2c+wbOB+2FGv3VNljaSbdE6a
         3SMg/uWxx7fZ6hqpXld9pMTZsW6bgG3Eb8dmF4g1MNfIN+6PAf10MAsofPuP+Phlq6Vc
         E3h+W1tl8Bk2UhWzz+ZNgkDIFS6y327BlOk1eNoFwRe5j1DJVFn6LnhWc/2r6TSiR9Qp
         w1P7ZX4U8ABoN0ZIvu0xXV7NMRz+3W2MMlHHTf8KhGRoPH2d1yYFs4s81tn2/IsRGd5J
         NJGO1R3vCmystwskQdsesMKuiacv1XjZaFk+eWBvElz2hSagBPCl7X4MR/rPtt5OOcbQ
         mgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775596; x=1760380396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3HHtGW+DSGKKUt7QI/vBAabeCHRr+hIur1q0oYGuCk=;
        b=rZm21KxzNyvl6WuNNF8OFnJb7zP3n3bJXpZnwLc82eaybu3HSQfqOVONT8JdoJxCSr
         YMqXUFfwhVnXTO+SmnSU8gsJ9HKTMcM1RAJlut+cvgq4ojzIIBnnY7C7Fdmf9PiBydkr
         1R/Aggt5Q60YWQdpaVnNpBDtTilgb5yG73s1G7JHRz/jAY+4uUcCljrmDhN6FaIi6Vup
         ocFj3KeUhHJc7GEjbwALa6R/+1NxPgzWfJY1XgI79mV5jcPOTWOJN2acOrE+EBIsKKlU
         Vy9y456U0+VhITzyKlb6s7SietE9hRk+OnwTbwPtyXJzld5JjKoSg07HpYBC9o6p07Nd
         Lw3A==
X-Forwarded-Encrypted: i=1; AJvYcCVpPo8h5QODncLnAUqkMXcMEeklKj3iaVVs1uaq/VkqJfmIavUJGL1Iq7G4l7NFjGzBitADJLsvhZDL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt5t7CO5CT2rBC7eWqBxbgHRSlZ9Pjd1z/3eZUmi0vHWpwOG08
	TfiuJW0e4UhRKSLq9Phm9AbwZFmNz1+xJyApCbhJVGRPbRixoT+cdxPCFsqF/nU47Xk=
X-Gm-Gg: ASbGncvpURWXZsjmXD+HiDIypfsMCYC9CvPX0aHi96ZjZk8pvZfCoYLM7gHfMSBQx6+
	XM40akIZcQss/9b+tNMSIHRnmk03HoJhge76u6ToCUUbI0JkNbcxv4WXupQIGIYi7KBuCQ/OPi0
	2qL5Onz0CnqASKeL3o1ur796oM6ukUHvf+c62wKcYI346j2gkHvUC2lVbC4Zl0OXv3iGNkKl++g
	X5SmHGFvzNtJEysXQcsKp62OEEyu/xh6ntv+gXFVPlP6Wn18jt+pI25Bh9+dU2oSxLaFyEImH8t
	4od8ai4Jh8KSqn5atNgN5t3e1KxVavQrngGwdnSlGa4K4z1CCoJUUhPz0Zi1gcheDUGPe2I+rqN
	L7Qsv0Tgyxe03ZgfpeQssybvAIYeXXsUcUZP7xlg0fLgVhkdzSKw=
X-Google-Smtp-Source: AGHT+IF/ipgF9R/d0+8mYXZQNHirXhPX4LiC+xxxIvWZdLWoGJbcH0wjp6j4UwK9dOl6j/ICVka+NQ==
X-Received: by 2002:a05:6000:2906:b0:3ec:db87:e8d7 with SMTP id ffacd0b85a97d-42566e05cffmr4347598f8f.0.1759775595774;
        Mon, 06 Oct 2025 11:33:15 -0700 (PDT)
Received: from [192.168.13.91] ([94.110.157.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8acc4csm21596082f8f.16.2025.10.06.11.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 11:33:15 -0700 (PDT)
Message-ID: <62d9cc76-6809-4832-90f7-d554b6b38ab7@b-kalm.com>
Date: Mon, 6 Oct 2025 20:33:14 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fpga: zynq-fpga: fix setting pcap to max speed
To: Xu Yilun <yilun.xu@linux.intel.com>, Michal Simek <michal.simek@amd.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org
References: <aN5zF8iaKlPqL9pZ@nuc> <aOMuWfxDkkjdfNGt@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Koen Beel <koen.beel@b-kalm.com>
In-Reply-To: <aOMuWfxDkkjdfNGt@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(resending because of formatting error; rejected by ml)
Hi Xu,
Thanks for the feedback.

I just checked, and this bug has always been there in zynq-fpga.c
So I could add:
    Fixes: 37784706bf9e ("fpga manager: Adding FPGA Manager support for Xilinx Zynq 7000")
but does this make it any more clear? It just feels kind of strange to add a fixes tag for such an old commit (that was the initial commit for this driver).
This commit will be 10 years old next week, so I honestly doubt this patch fixes a critical bug that needs to go into stable.

Some more details about the failure:
Fpga programming for non-secure bitstreams is broken, unless some bootloader changes the reset value of PCAP_RATE_EN.
This is the error I get (after which the bitstream is _not_ programmed):
    # echo fpga.bin > /sys/class/fpga_manager/fpga0/firmware
    fpga_manager fpga0: writing fpga.bin to Xilinx Zynq FPGA Manager
    fpga_manager fpga0: Error after writing image data to FPGA
    sh: write error: Connection timed out

My board is a Trenz TE0715 + custom carrier board.
Now also tested on a standard ZedBoard. Same bug behavior and patch also fixes this.
Can't test secure bitstreams here (don't have any).

According to the "Zynq 7000 SoC Technical Reference Manual (UG585)" the reset value of the register XDCFG_CTRL_OFFSET (0xF8007000) should be 0x0C006000
So XDCFG_CTRL_PCAP_RATE_EN_MASK should have a reset value of 0.
However, I tested on both my board and ZedBoard, and the actual reset value of this register seems to be 0x4E00E07F ... (strange, AMD?)
So this PCA_RATE_EN_MASK (bit 25) is actually already set (=1) at bootup.
(I don't have a hardware debugger, but print this value very early in uboot SPL, right after debug_uart init, and have checked this register value is not overwritten by ps7_init).

And yes, this bit is also still set when reading XDCFG_CTRL_OFFSET in zynq-fpga.c
Ok, the problem I have is a timeout when writing the bitstream, and this timeout should not happen even if the bitstream write speed is reduced to 25% (PCAP_RATE_EN = 1 does this), unless it's a HW problem.
So this timeout may be another bug to look into, but at least this fix is a workaround for that timeout, and it's also a valid fix for an actual bug imo.

Someone else able to test this? And test with secure bitstreams?

No idea if this timeout has always been there, but I assume things have ever worked without this timeout problem for zynq-fpga.
And I assume I'm not the only one having this problem, but I know Xilinx FSBL does reset this bit (=0) when writing a bitstream before starting uboot. And doing this hides this bug in zynq-fpga. No idea who is using xlnx fsbl and use it to write a bitstream before uboot, but I assume many people, since this is the "default option".

Anyway, I don't think it's sane to just assume a register has a certain value and just depend on it.

I'm ok with the proposed change. That's indeed more clear. Should I send a v2?

Thanks,
Koen

On 06/10/2025 04:50, Xu Yilun wrote:
> On Thu, Oct 02, 2025 at 02:41:59PM +0200, Koen Beel wrote:
>> The PCAP interface should be set to max speed if the bitstream is not
>> encrypted.
>> The code comments mention this should be done, but it wasn't the case.
> 
> Use 'fixes' tag and Cc stable kernel if it is a BUG.
> 
>> On my board, this fixes failure of programming the (non-encrypted)
>> bitstream.
> 
> Could you elaborate on the details of the failure, rather than just "on
> my board it fails".
> 
>>
>> Signed-off-by: Koen Beel <koen.beel@b-kalm.com>
>> ---
>>  drivers/fpga/zynq-fpga.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>> index b7629a0e4813..1872ce05b566 100644
>> --- a/drivers/fpga/zynq-fpga.c
>> +++ b/drivers/fpga/zynq-fpga.c
>> @@ -354,8 +354,8 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>>  				 | CTRL_PCAP_RATE_EN_MASK | ctrl));
>>  	else
>>  		zynq_fpga_write(priv, CTRL_OFFSET,
>> -				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
>> -				 | ctrl));
>> +				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl)
>> +				 & ~CTRL_PCAP_RATE_EN_MASK);
> 
> So do you mean the CTRL_PCAP_RATE_EN_MASK bit is already set in 'ctrl' when
> you read it out?
> 
> And it is harder for me to always check all masks for both
> encrypted/non-encrypted cases.  Only the CTRL_PCAP_RATE_EN_MASK is
> different so if the following works for you:
> 
> ------------8<--------------
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index b7629a0e4813..497ed4958b0a 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -348,15 +348,10 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>          * - set CPU in user mode
>          */
>         ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
> -       if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM)
> -               zynq_fpga_write(priv, CTRL_OFFSET,
> -                               (CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
> -                                | CTRL_PCAP_RATE_EN_MASK | ctrl));
> -       else
> -               zynq_fpga_write(priv, CTRL_OFFSET,
> -                               (CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
> -                                | ctrl));
> -
> +       ctrl |= CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK;
> +       FIELD_MODIFY(CTRL_PCAP_RATE_EN_MASK, &ctrl,
> +                    (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM) ? 1 : 0);
> +       zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
> 
>         /* We expect that the command queue is empty right now. */
>         status = zynq_fpga_read(priv, STATUS_OFFSET);
> 
>>  
>>  
>>  	/* We expect that the command queue is empty right now. */
>> -- 
>> 2.51.0
>>
>>


