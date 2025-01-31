Return-Path: <linux-fpga+bounces-1030-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB7A23FA2
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 16:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33801885037
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD11E7668;
	Fri, 31 Jan 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCkLUV0C"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020F1E5726;
	Fri, 31 Jan 2025 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337198; cv=none; b=lgFWRS84FNZgkZrGHrjiV7lGyj5s11bdmpy4g3fY9jHBYby1722GHyLobNvzCic0tu0IA9iwUKivbrTBOcjTPs5sAwHNRSKksA3ukaU13MtR7JwMORGWQOwvNMw66FgtTji/rDzB4v3iDmTR69Sw0DYKDmVZXKFdHBmFfEYiUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337198; c=relaxed/simple;
	bh=2ULc8BQm7YXjgGqlZjsV9DB9CeqZcoDXnGE2In5vW8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dnou3waagGbDmSIvH7f+VFIxlzcdurTliQaikcRKN8brL3/+e0uzr7gygwqFjyP8aMmdb7ZItWlQizD3VZqKoaqM29mf1SwO4elejX8oKmj4fejcrZBCsVmrEYqsyedXo7vZ6jj2EFlAV+ujksnaPSRZincFpKfnDRR/Ugha1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCkLUV0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F83C4CED1;
	Fri, 31 Jan 2025 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738337197;
	bh=2ULc8BQm7YXjgGqlZjsV9DB9CeqZcoDXnGE2In5vW8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCkLUV0CAuTQQxKl8ODLqJGj0vdDlwr8WZoM5FlP8aCtVGSWsRVh7dprcddJe6qeP
	 r0ST2yxkOx1tHjnjcTaiOzp8UgCKZCDquNy003DM0gYSEURdLXQtlpeMxGBWQBxEQ2
	 sFbc9sqGtmkJQjSwFqVVEq6j5OBw2IzqpMcyQ/3U5whp/KyHOs5Z/cBFe+Doa9OSpg
	 0mE7A9znT6OLiO3nQopvgk2Xdv95IxRs8kAeSg/RKDvsn8H5l+QkcNcpxASZ8fM/9J
	 NLYO6mSt0WVcTytQCSHV0CL3XfO66ZTBHVBnVS9vYuu0kaSlakNKfjy7BHXxyoF+OH
	 GWKpFpl/Cor7A==
Date: Fri, 31 Jan 2025 09:26:36 -0600
From: Rob Herring <robh@kernel.org>
To: Mahesh Rao <mahesh.rao@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Wu Hao <hao.wu@intel.com>, Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
Message-ID: <20250131152636.GA3454395-robh@kernel.org>
References: <20250131-socfpga_sip_svc_misc-v2-0-eeed4ebc35f9@intel.com>
 <20250131-socfpga_sip_svc_misc-v2-2-eeed4ebc35f9@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-socfpga_sip_svc_misc-v2-2-eeed4ebc35f9@intel.com>

On Fri, Jan 31, 2025 at 06:17:25PM +0800, Mahesh Rao wrote:
> Convert intel,stratix10-svc service layer devicetree
> binding file from freeform format to json-schema.
> 
> Also added DT binding for optional stratix10-soc
> FPGA manager child node.
> 
> Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
> ---
>  .../bindings/firmware/intel,stratix10-svc.txt      | 57 -------------
>  .../bindings/firmware/intel,stratix10-svc.yaml     | 94 ++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 57 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
> deleted file mode 100644
> index 6eff1afd8daf91714d6a18859667d2607e707da7..0000000000000000000000000000000000000000
> --- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -Intel Service Layer Driver for Stratix10 SoC
> -============================================
> -Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
> -processor system (HPS) and Secure Device Manager (SDM). When the FPGA is
> -configured from HPS, there needs to be a way for HPS to notify SDM the
> -location and size of the configuration data. Then SDM will get the
> -configuration data from that location and perform the FPGA configuration.
> -
> -To meet the whole system security needs and support virtual machine requesting
> -communication with SDM, only the secure world of software (EL3, Exception
> -Layer 3) can interface with SDM. All software entities running on other
> -exception layers must channel through the EL3 software whenever it needs
> -service from SDM.
> -
> -Intel Stratix10 service layer driver, running at privileged exception level
> -(EL1, Exception Layer 1), interfaces with the service providers and provides
> -the services for FPGA configuration, QSPI, Crypto and warm reset. Service layer
> -driver also manages secure monitor call (SMC) to communicate with secure monitor
> -code running in EL3.
> -
> -Required properties:
> --------------------
> -The svc node has the following mandatory properties, must be located under
> -the firmware node.
> -
> -- compatible: "intel,stratix10-svc" or "intel,agilex-svc"
> -- method: smc or hvc
> -        smc - Secure Monitor Call
> -        hvc - Hypervisor Call
> -- memory-region:
> -	phandle to the reserved memory node. See
> -	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> -	for details
> -
> -Example:
> --------
> -
> -	reserved-memory {
> -                #address-cells = <2>;
> -                #size-cells = <2>;
> -                ranges;
> -
> -                service_reserved: svcbuffer@0 {
> -                        compatible = "shared-dma-pool";
> -                        reg = <0x0 0x0 0x0 0x1000000>;
> -                        alignment = <0x1000>;
> -                        no-map;
> -                };
> -        };
> -
> -	firmware {
> -		svc {
> -			compatible = "intel,stratix10-svc";
> -			method = "smc";
> -			memory-region = <&service_reserved>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..e30e79d4c3150f90993e728320e9ef90d484a10d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/intel,stratix10-svc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Service Layer Driver for Stratix10 SoC
> +
> +maintainers:
> +  - Dinh Nguyen <dinguyen@kernel.org>
> +  - Mahesh Rao <mahesh.rao@altera.com>
> +
> +description:

You need '>' on the end to preserve paragraphs.

> +  Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
> +  processor system (HPS) and Secure Device Manager (SDM). When the FPGA is
> +  configured from HPS, there needs to be a way for HPS to notify SDM the
> +  location and size of the configuration data. Then SDM will get the
> +  configuration data from that location and perform the FPGA configuration.
> +
> +  To meet the whole system security needs and support virtual machine requesting
> +  communication with SDM, only the secure world of software (EL3, Exception
> +  Layer 3) can interface with SDM. All software entities running on other
> +  exception layers must channel through the EL3 software whenever it needs
> +  service from SDM.
> +
> +  Intel Stratix10 service layer driver, running at privileged exception level
> +  (EL1, Exception Layer 1), interfaces with the service providers and provides
> +  the services for FPGA configuration, QSPI, Crypto and warm reset. Service layer
> +  driver also manages secure monitor call (SMC) to communicate with secure monitor
> +  code running in EL3.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,stratix10-svc
> +      - intel,agilex-svc
> +
> +  method:
> +    description: |
> +                 Supervisory call method to be used to communicate with the
> +                 secure service layer.
> +                 Permitted values are:
> +                 - "smc" : SMC #0, following the SMCCC
> +                 - "hvc" : HVC #0, following the SMCCC

Indent by 2 more than 'description'.

> +
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    enum:
> +      - smc
> +      - hvc
> +
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      phandle to a reserved memory region for the service layer driver to
> +      communicate with the secure device manager. For more details see
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt.

Please read what that file says.

> +
> +  fpga-mgr:
> +    $ref: /schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml
> +    description: Optional child node for fpga manager to perform fabric configuration.
> +
> +required:
> +  - compatible
> +  - method
> +  - memory-region
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      service_reserved: svcbuffer@0 {
> +              compatible = "shared-dma-pool";
> +              reg = <0x0 0x0 0x0 0x1000000>;
> +              alignment = <0x1000>;
> +              no-map;
> +      };
> +    };
> +
> +    firmware {
> +      svc {
> +        compatible = "intel,stratix10-svc";
> +        method = "smc";
> +        memory-region = <&service_reserved>;
> +
> +        fpga-mgr {
> +          compatible = "intel,stratix10-soc-fpga-mgr";
> +        };
> +      };
> +    };
> +
> 
> -- 
> 2.35.3
> 

