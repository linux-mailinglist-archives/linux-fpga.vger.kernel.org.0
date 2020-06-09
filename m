Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345CA1F3EC9
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Jun 2020 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgFIPBs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Jun 2020 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730639AbgFIPBl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Jun 2020 11:01:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F905C05BD1E
        for <linux-fpga@vger.kernel.org>; Tue,  9 Jun 2020 08:01:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 69so16849637otv.2
        for <linux-fpga@vger.kernel.org>; Tue, 09 Jun 2020 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fV8ZFDB43FV3g5g5fZTxYLi7vsPxA13YSgKOxxB6Lc4=;
        b=ifgMqLNaEDoJ3ggtZ+CDKXlxlAhzRY618v/+r51qXTg5XTFIpLHDYpOowMjKcjIxfH
         TS9NlRSEADUBQ12AB25ifuTk2OIXnmtJ5PptilvJ0j8B/+B1Y69m5jA7/p0DkP1IjQ6+
         yEOpkGL/mNoOp/IWAhjZxONzJuJU9Z3p8hbNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fV8ZFDB43FV3g5g5fZTxYLi7vsPxA13YSgKOxxB6Lc4=;
        b=BO8KvwcH9jkumLZEJSREoe1c/udpqvZcBIBJ7sFhlXGmqsWikRRv/aEeV43rWvjMGj
         lyKTdjNUbx6A3uDeQXZq8YYgMP3yarcJA4MILQfbz7X+4+4YQGID26wnZWolRUiGL8Ne
         AcdU7McP+zsUGflTC8cA+anX2Dz2s1M5MEWGcuXk5unaO2xjitFmER3mNzUdvHZC2pHr
         H1s6C6pyl93CpprNlkNaTaGx/UfHMuVYwN+ksCWhAqm0XLZQnuP9J5g54jMR4qvCN/oA
         2woBwEb+hLDxe8y2UdMiYYElQ9eO770m1sDVMQ3cZqVd0I+cqR4gvs1AgSWQzCBbwu3t
         4Oig==
X-Gm-Message-State: AOAM533kK91BduqCMyj+m4jyKEvbPRcRHHLu8sZXIcwr14B/1gXvLrxb
        HOqkeYWjADgS7Du23S+5js1tJg==
X-Google-Smtp-Source: ABdhPJxGmnoepX29AANMk4+Z5b3vk+XlqO9YIXrRdoke3DisNE70ra7JK0DqrOFn056B0XzmgUHgGQ==
X-Received: by 2002:a9d:969:: with SMTP id 96mr15323599otp.319.1591714897141;
        Tue, 09 Jun 2020 08:01:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s124sm3209070oig.19.2020.06.09.08.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 08:01:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftests: fpga: dfl: A test for afu interrupt
 support
To:     Tom Rix <trix@redhat.com>, Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>, linux-fpga@vger.kernel.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200609130208.27390-1-trix@redhat.com>
 <20200609130208.27390-2-trix@redhat.com> <20200609142007.GA831428@kroah.com>
 <d3d8e518-0760-8cbe-cf74-191f70329a46@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <340c25e4-579b-a06b-49ae-63937dc0fbf0@linuxfoundation.org>
Date:   Tue, 9 Jun 2020 09:01:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d3d8e518-0760-8cbe-cf74-191f70329a46@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 6/9/20 8:45 AM, Tom Rix wrote:
> 
>> Why not use the ksft_* functions and frameworks to properly print out
>> the test status and results so that tools can correctly parse it?
>>
>> It's generally bad-form to make up your own format.
> 
> I used the the drivers/dma-buf test a basis example.  Can you point me at a better example ?
> 

A few examples to choose from as a reference:

tools/testing/selftests/breakpoints
tools/testing/selftests/timens

Please reach out to me if you have any questions.

thanks,
-- Shuah


