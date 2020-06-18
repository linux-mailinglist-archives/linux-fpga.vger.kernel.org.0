Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54B81FEB16
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Jun 2020 07:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgFRFrj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Jun 2020 01:47:39 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:52128 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgFRFrj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Jun 2020 01:47:39 -0400
Received: from [37.162.76.16] (port=34618 helo=[192.168.43.3])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jlnOg-000Fdz-JC; Thu, 18 Jun 2020 07:47:34 +0200
Subject: Re: [PATCH 4/5] dt-bindings: fpga: xilinx-slave-serial: add optional
 INIT_B GPIO
To:     Rob Herring <robh@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
 <20200611211144.9421-4-luca@lucaceresoli.net>
 <20200617223955.GA2967317@bogus>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <b2c064c0-9a52-890d-b026-9cc1f4cab7d0@lucaceresoli.net>
Date:   Thu, 18 Jun 2020 07:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617223955.GA2967317@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Rob, Moritz,

On 18/06/20 00:39, Rob Herring wrote:
> On Thu, Jun 11, 2020 at 11:11:43PM +0200, Luca Ceresoli wrote:
>> The INIT_B is used by the 6 and 7 series to report the programming status,
>> providing more control and information about programming errors.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt       | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
>> index 9f103f3872e8..a049082e1513 100644
>> --- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
>> +++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
>> @@ -16,6 +16,10 @@ Required properties:
>>  - prog_b-gpios: config pin (referred to as PROGRAM_B in the manual)
>>  - done-gpios: config status pin (referred to as DONE in the manual)
>>  
>> +Optional properties:
>> +- init_b-gpios: initialization status and configuration error pin
>> +                (referred to as INIT_B in the manual)
> 
> Don't use '_' in property names:
> 
> init-b-gpios

OK, will fix.

Moritz, please don't apply this version of patches 4 and 5 if you still
haven't done so.

Now what about the existing prog_b-gpios property? Should we just leave
it as is for backward compatibility, or is there a migration path to fix
it as well?

Thanks.
-- 
Luca
